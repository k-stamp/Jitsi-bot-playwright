const { chromium } = require('playwright');
const fs = require('fs');
const path = require('path');

// Prüfe, ob die config.json existiert
let config;
try {
  config = require('./config.json');
  console.log('Konfiguration geladen:', JSON.stringify(config, null, 2));
} catch (err) {
  console.error('Fehler beim Laden der config.json:', err.message);
  console.error('Bitte stelle sicher, dass die Datei existiert und gültiges JSON enthält.');
  process.exit(1);
}

// Debug-Hilfsfunktion
function debug(message) {
  if (config.debug) {
    console.log(`[DEBUG] ${message}`);
  }
}

// Neue Hilfsfunktion für Zeitstempel-Logging
function logWithTimestamp(message) {
  const timestamp = new Date().toISOString();
  console.log(`[${timestamp}] ${message}`);
}

// Hauptfunktion
(async () => {
  console.log(`Starte ${config.numberofbots} Bots für die Konferenz: ${config.url}`);
  
  if (config.debug) {
    console.log('DEBUG-MODUS AKTIVIERT');
    console.log('Systeminformationen:');
    console.log('- Node.js Version:', process.version);
    console.log('- Plattform:', process.platform);
    console.log('- Architektur:', process.arch);
  }

  // Validierung: Prüfe ob genügend Bot-Konfigurationen vorhanden sind
  if (!config.bots || config.bots.length < config.numberofbots) {
    console.error(`Fehler: Es sind nur ${config.bots?.length || 0} Bot-Konfigurationen vorhanden, aber ${config.numberofbots} Bots angefordert.`);
    process.exit(1);
  }

  // OPTIMIERTE LOGIK: Bots in Batches mit gestaffeltem Start
  console.log(`Starte Bots in Batches mit ${config.delayBetweenBots}ms Abstand zwischen den Bots...`);

  const browsers = [];
  const batchSize = 4; // Maximal 4 Bots gleichzeitig starten
  const batchDelay = 2000; // 2 Sekunden zwischen Batches

  // Teile Bots in Batches auf
  const batches = [];
  for (let i = 0; i < config.numberofbots; i += batchSize) {
    batches.push(config.bots.slice(i, i + batchSize));
  }

  console.log(`Starte ${config.numberofbots} Bots in ${batches.length} Batches (${batchSize} Bots pro Batch)`);

  // Verarbeite jeden Batch
  for (let batchIndex = 0; batchIndex < batches.length; batchIndex++) {
    const batch = batches[batchIndex];
    
    if (batchIndex > 0) {
      console.log(`Warte ${batchDelay}ms vor dem nächsten Batch...`);
      await new Promise(resolve => setTimeout(resolve, batchDelay));
    }
    
    console.log(`Starte Batch ${batchIndex + 1}/${batches.length} mit ${batch.length} Bots...`);
    
    // Starte Bots in diesem Batch parallel mit gestaffelter Verzögerung
    const batchPromises = batch.map((botConfig, batchBotIndex) => {
      const globalBotIndex = batchIndex * batchSize + batchBotIndex;
      
      return new Promise(async (resolve) => {
        // Gestaffelte Verzögerung innerhalb des Batches
        const delay = batchBotIndex * config.delayBetweenBots;
        
        if (delay > 0) {
          console.log(`Bot ${globalBotIndex + 1} wartet ${delay}ms vor dem Start...`);
          await new Promise(resolveDelay => setTimeout(resolveDelay, delay));
        }
        
        console.log(`Starte Bot ${globalBotIndex + 1} (${botConfig.name})...`);
        try {
          const result = await startUser(globalBotIndex, botConfig, browsers);
          resolve(result);
        } catch (error) {
          console.error(`Bot ${globalBotIndex + 1} Fehler:`, error.message);
          resolve(null);
        }
      });
    });
    
    // Warte auf alle Bots in diesem Batch
    const batchResults = await Promise.all(batchPromises);
    console.log(`Batch ${batchIndex + 1} abgeschlossen. Erfolgreiche Bots: ${batchResults.filter(r => r !== null).length}/${batch.length}`);
  }

  console.log('Alle Bots sind gestartet!');
  
  console.log('Synchroner Start von Audio und Video für alle Bots!');
  
  // Hier könnten Sie zusätzliche Synchronisationslogik hinzufügen,
  // falls Sie spezielle Audio/Video-Steuerung benötigen

  async function startUser(index, botConfig, browsersArray) {
    // Absolute Pfade zu den Medien-Dateien für diesen Bot
    const videoFile = path.resolve(path.join(__dirname, 'media', botConfig.mediaFolder, botConfig.videoFile));
    const audioFile = path.resolve(path.join(__dirname, 'media', botConfig.mediaFolder, botConfig.audioFile));
    
    console.log(`Bot ${index + 1} (${botConfig.name}):`);
    console.log(`- Video-Datei: ${videoFile}`);
    if (botConfig.enableAudio) {
      console.log(`- Audio-Datei: ${audioFile}`);
    }
    console.log(`- Audio aktiviert: ${botConfig.enableAudio || false}`);
    
    // Prüfe, ob die Video-Datei existiert
    if (!fs.existsSync(videoFile)) {
      console.error(`Video-Datei nicht gefunden: ${videoFile}`);
      return null;
    }
    
    // Prüfe Audio-Datei nur, wenn Audio für diesen Bot aktiviert ist
    if (botConfig.enableAudio && !fs.existsSync(audioFile)) {
      console.error(`Audio-Datei nicht gefunden: ${audioFile}`);
      return null;
    }

    // Launch-Optionen - unterschiedliche Konfiguration je nach Audio-Status
    const baseArgs = [
      '--allow-file-access-from-files',
      '--autoplay-policy=no-user-gesture-required',
      '--disable-web-security',
      '--ignore-certificate-errors'
    ];

    const launchOptions = {
      headless: config.headless === true,
      args: [...baseArgs],
      ignoreHTTPSErrors: true
    };

    // Nur wenn Audio aktiviert ist, füge Audio-spezifische Argumente hinzu
    if (botConfig.enableAudio) {
      launchOptions.args.push(
        '--auto-accept-camera-and-microphone-capture',
        '--use-fake-device-for-media-stream'
      );
      
      // Video nur hinzufügen, wenn global aktiviert
      if (config.enableVideo) {
        launchOptions.args.push(`--use-file-for-fake-video-capture=${videoFile}`);
      }
      
      launchOptions.args.push(`--use-file-for-fake-audio-capture=${audioFile}`);
    } else {
      // Für Bots ohne Audio: Mikrofon komplett deaktivieren
      launchOptions.args.push(
        '--auto-accept-camera-and-microphone-capture',
        '--use-fake-device-for-media-stream'
      );
      
      // Video nur hinzufügen, wenn global aktiviert
      if (config.enableVideo) {
        launchOptions.args.push(`--use-file-for-fake-video-capture=${videoFile}`);
      }
      
      launchOptions.args.push(
        '--disable-features=VizDisplayCompositor',
        '--mute-audio'
      );
    }

    console.log(`Bot ${index + 1} Chrome-Argumente:`, launchOptions.args);

    const browser = await chromium.launch(launchOptions);
    browsersArray.push(browser);
    
    // Unterschiedliche Berechtigungen je nach Audio-Status und Video-Status
    const permissions = [];
    if (config.enableVideo) {
      permissions.push('camera');
    }
    // WICHTIG: Auch für Bots ohne Audio die Mikrofonberechtigung geben
    // um Jitsi nicht zu verwirren
    permissions.push('microphone');
    
    const context = await browser.newContext({
      viewport: { width: 1280, height: 720 },
      permissions: permissions,
      ignoreHTTPSErrors: true
    });

    if (permissions.length > 0) {
      await context.grantPermissions(permissions);
    }

    const botName = botConfig.name || config.customname;
    const page = await context.newPage();

    // Für Bots ohne Audio: Bessere Audio-Deaktivierung
    if (!botConfig.enableAudio) {
      await page.addInitScript(() => {
        // Überschreibe getUserMedia um einen stummen Audio-Stream zu liefern
        const originalGetUserMedia = navigator.mediaDevices.getUserMedia;
        navigator.mediaDevices.getUserMedia = async function(constraints) {
          try {
            if (constraints && constraints.audio) {
              // Erstelle einen stummen Audio-Stream statt Audio zu entfernen
              const audioContext = new (window.AudioContext || window.webkitAudioContext)();
              const oscillator = audioContext.createOscillator();
              const gainNode = audioContext.createGain();
              const destination = audioContext.createMediaStreamDestination();
              
              // Setze Lautstärke auf 0 (stumm)
              gainNode.gain.setValueAtTime(0, audioContext.currentTime);
              
              oscillator.connect(gainNode);
              gainNode.connect(destination);
              oscillator.start();
              
              // Wenn auch Video angefordert wird, kombiniere die Streams
              if (constraints.video) {
                const videoStream = await originalGetUserMedia.call(
                  navigator.mediaDevices, 
                  { video: constraints.video }
                );
                
                const combinedStream = new MediaStream();
                // Füge stummen Audio-Track hinzu
                destination.stream.getAudioTracks().forEach(track => {
                  combinedStream.addTrack(track);
                });
                // Füge Video-Tracks hinzu
                videoStream.getVideoTracks().forEach(track => {
                  combinedStream.addTrack(track);
                });
                
                return combinedStream;
              }
              
              return destination.stream;
            }
            
            // Für alle anderen Fälle die Original-Funktion verwenden
            return originalGetUserMedia.call(navigator.mediaDevices, constraints);
          } catch (error) {
            console.error('Fehler bei der Audio-Deaktivierung:', error);
            // Fallback: Original-Funktion verwenden
            return originalGetUserMedia.call(navigator.mediaDevices, constraints);
          }
        };
        
        console.log('Stummer Audio-Stream für Bot ohne Audio erstellt');
      });
    }

    console.log(`Bot ${index + 1} (${botName}): Starte...`);

    try {
      // Direkt zur Jitsi-URL navigieren mit längerem Timeout
      console.log(`Bot ${index + 1} (${botName}): Navigiere zur Konferenz...`);
      await page.goto(config.url, { 
        timeout: 60000, // 60 Sekunden statt 30
        waitUntil: 'domcontentloaded' // Warte nur auf DOM, nicht auf alle Ressourcen
      });
      console.log(`Bot ${index + 1} (${botName}): Zur Konferenz navigiert`);

      // Warte auf Name-Eingabefeld mit längerem Timeout
      const nameField = 'div.premeeting-screen input';
      await page.waitForSelector(nameField, { timeout: 15000 }); // 15 Sekunden
      await page.fill(nameField, botName);
      
      // Meeting beitreten
      const joinButton = 'div[data-testid="prejoin.joinMeeting"]';
      await page.waitForSelector(joinButton, { timeout: 10000 });
      await page.click(joinButton);
      console.log(`Bot ${index + 1} (${botName}): Meeting beigetreten`);

      // Warte bis Bot wirklich in der Konferenz ist
      await page.waitForTimeout(2000);

      // Automatisches Verlassen nach konfigurierter Zeit
      if (config.autoLeaveAfter && config.autoLeaveAfter > 0) {
        logWithTimestamp(`Bot ${index + 1} (${botName}): Wird die Konferenz in ${config.autoLeaveAfter}ms verlassen`);
        
        setTimeout(async () => {
          try {
            logWithTimestamp(`Bot ${index + 1} (${botName}): Startet automatisches Verlassen der Konferenz nach ${config.autoLeaveAfter}ms`);
            await leaveConference(page, botName, index + 1, browser);
          } catch (err) {
            logWithTimestamp(`Bot ${index + 1} (${botName}): Fehler beim automatischen Verlassen der Konferenz: ${err.message}`);
          }
        }, config.autoLeaveAfter);
      }

      // Event-Listener für unerwartetes Schließen der Seite hinzufügen
      page.on('close', () => {
        logWithTimestamp(`Bot ${index + 1} (${botName}): Seite wurde unerwartet geschlossen`);
      });

      // Event-Listener für Browser-Disconnect
      browser.on('disconnected', () => {
        logWithTimestamp(`Bot ${index + 1} (${botName}): Browser wurde getrennt`);
      });

      return { page, browser, botName, index: index + 1 };

    } catch (err) {
      console.error(`Bot ${index + 1} (${botName}): Fehler: ${err.message}`);
      
      // Detailliertere Fehlerbehandlung
      if (err.message.includes('Timeout')) {
        console.error(`Bot ${index + 1}: Timeout-Fehler - möglicherweise Systemüberlastung`);
      }
      
      await browser.close();
      return null;
    }
  }

  // Funktion zum Verlassen der Konferenz
  async function leaveConference(page, botName, botIndex, browser) {
    try {
      logWithTimestamp(`Bot ${botIndex} (${botName}): VERLASSEN GESTARTET - Bot möchte die Konferenz verlassen`);
      debug(`Bot ${botIndex} (${botName}): Versuche Konferenz zu verlassen...`);
      
      // Ersten Button klicken (Hangup-Button in der Toolbar)
      const hangupButton = '#new-toolbox > div > div > div > div:nth-child(10) > div > div';
      await page.waitForSelector(hangupButton, { timeout: 5000 });
      logWithTimestamp(`Bot ${botIndex} (${botName}): Hangup-Button gefunden, klicke jetzt...`);
      await page.click(hangupButton);
      debug(`Bot ${botIndex} (${botName}): Hangup-Button geklickt`);
      
      // Länger warten, bis das Modal vollständig geladen ist
      await page.waitForTimeout(2000);
      
      // Warten bis der Bestätigungs-Button sichtbar und klickbar ist
      const confirmButton = 'body > div:nth-child(4) > div:nth-child(2) > div > div > div:nth-child(2) > div > button.css-5yedmr-button-secondary-medium-fullWidth';
      await page.waitForSelector(confirmButton, { timeout: 10000 });
      
      // Zusätzlich warten, bis der Button wirklich klickbar ist
      await page.waitForFunction(
        (selector) => {
          const button = document.querySelector(selector);
          return button && !button.disabled && button.offsetParent !== null;
        },
        confirmButton,
        { timeout: 5000 }
      );
      
      debug(`Bot ${botIndex} (${botName}): Bestätigungs-Button ist bereit`);
      logWithTimestamp(`Bot ${botIndex} (${botName}): Bestätigungs-Button bereit, bestätige Verlassen...`);
      
      // Noch eine kurze Pause vor dem Klick
      await page.waitForTimeout(500);
      
      await page.click(confirmButton);
      debug(`Bot ${botIndex} (${botName}): Bestätigungs-Button geklickt`);
      
      logWithTimestamp(`Bot ${botIndex} (${botName}): VERLASSEN ABGESCHLOSSEN - Hat die Konferenz erfolgreich verlassen`);
      
      // Kurz warten bevor die Seite geschlossen wird
      await page.waitForTimeout(1000);
      await page.close();
      
      // Browser schließen nach dem Verlassen
      await browser.close();
      logWithTimestamp(`Bot ${botIndex} (${botName}): Browser geschlossen`);
      
    } catch (err) {
      logWithTimestamp(`Bot ${botIndex} (${botName}): FEHLER BEIM VERLASSEN: ${err.message}`);
      console.error(`Bot ${botIndex} (${botName}): Fehler beim Verlassen: ${err.message}`);
      await browser.close();
    }
  }

  // Optional: Halte das Skript am Leben, bis STRG+C gedrückt wird
  if (!config.autoclose) {
    console.log('Drücke STRG+C, um alle Bots zu beenden...');
    
    // Event-Handler für sauberes Beenden
    process.on('SIGINT', async () => {
      console.log('Beende alle Bots und schließe Browser...');
      // Schließe alle Browser
      for (const browser of browsers) {
        try {
          await browser.close();
        } catch (err) {
          console.error('Fehler beim Schließen eines Browsers:', err.message);
        }
      }
      process.exit(0);
    });
    
    // Halte Prozess am Leben
    await new Promise(() => {});
  } else {
    // Schließe Browser nach der konfigurierten Laufzeit
    console.log(`Bots laufen für ${config.runtime || 60000}ms und werden dann automatisch beendet.`);
    await new Promise(resolve => setTimeout(resolve, config.runtime || 60000));
    
    // Schließe alle Browser
    for (const browser of browsers) {
      try {
        await browser.close();
      } catch (err) {
        console.error('Fehler beim Schließen eines Browsers:', err.message);
      }
    }
    console.log('Alle Bots wurden beendet.');
  }
})().catch(err => {
  console.error('Unerwarteter Fehler:', err);
  console.error('Stack-Trace:', err.stack);
  
  if (err.message.includes('Target page, context or browser has been closed')) {
    console.error('\nDieses Problem tritt häufig im Headless-Modus auf.');
    console.error('Lösungsvorschläge:');
    console.error('1. Setze "headless": false in der config.json');
    console.error('2. Stelle sicher, dass der Chrome-Browser auf deinem System installiert ist');
    console.error('3. Auf Mac: Stelle sicher, dass du Kamera/Mikrofonzugriff in den Systemeinstellungen erlaubt hast');
  }
  
  process.exit(1);
});