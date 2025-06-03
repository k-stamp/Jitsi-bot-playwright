const { chromium } = require('playwright');
const { uniqueNamesGenerator, adjectives, colors, animals, NumberDictionary } = require('unique-names-generator');
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

  // Starte die Bots
  for (let i = 0; i < config.numberofbots; i++) {
    const botConfig = config.bots[i];
    await startUser(i, botConfig);
    await new Promise(resolve => setTimeout(resolve, config.delayBetweenBots || 5000));
  }

  async function startUser(index, botConfig) {
    // Absolute Pfade zu den Medien-Dateien für diesen Bot
    const videoFile = path.resolve(path.join(__dirname, 'media', botConfig.mediaFolder, botConfig.videoFile));
    const audioFile = path.resolve(path.join(__dirname, 'media', botConfig.mediaFolder, botConfig.audioFile));
    
    console.log(`Bot ${index + 1} (${botConfig.name}):`);
    console.log(`- Video-Datei: ${videoFile}`);
    console.log(`- Audio-Datei: ${audioFile}`);
    
    // Prüfe, ob die Dateien existieren
    if (!fs.existsSync(videoFile)) {
      console.error(`Video-Datei nicht gefunden: ${videoFile}`);
      return; // Überspringe diesen Bot, aber stoppe nicht das gesamte Programm
    }
    
    if (!fs.existsSync(audioFile)) {
      console.error(`Audio-Datei nicht gefunden: ${audioFile}`);
      return; // Überspringe diesen Bot, aber stoppe nicht das gesamte Programm
    }

    // Launch-Optionen mit Video-File-Injection für diesen Bot
    const launchOptions = {
      headless: config.headless === true,
      args: [
        '--auto-accept-camera-and-microphone-capture',
        '--use-fake-device-for-media-stream',
        `--use-file-for-fake-video-capture=${videoFile}`,
        `--use-file-for-fake-audio-capture=${audioFile}`,
        '--allow-file-access-from-files',
        '--autoplay-policy=no-user-gesture-required',
        '--disable-web-security'
      ]
    };

    console.log(`Bot ${index + 1} Chrome-Argumente:`, launchOptions.args);

    const browser = await chromium.launch(launchOptions);
    const context = await browser.newContext({
      viewport: { width: 1280, height: 720 },
      permissions: ['camera', 'microphone']
    });

    await context.grantPermissions(['camera', 'microphone']);

    const randomName = uniqueNamesGenerator({ 
      dictionaries: [colors, adjectives, animals], 
      separator: "", 
      length: 2, 
      style: 'capital' 
    }) + NumberDictionary.generate({ min: 10, max: 9999 });
    
    const botName = config.userandomnames ? randomName : (botConfig.name || config.customname);
    const page = await context.newPage();

    console.log(`Bot ${index + 1} (${botName}): Starte...`);

    try {
      // Direkt zur Jitsi-URL navigieren
      await page.goto(config.url);
      console.log(`Bot ${index + 1} (${botName}): Zur Konferenz navigiert`);

      // Warte auf Name-Eingabefeld
      const nameField = 'div.premeeting-screen input';
      await page.waitForSelector(nameField, { timeout: 10000 });
      await page.fill(nameField, botName);
      
      // Meeting beitreten
      const joinButton = 'div[data-testid="prejoin.joinMeeting"]';
      await page.click(joinButton);
      console.log(`Bot ${index + 1} (${botName}): Meeting beigetreten`);

      // Kurz warten, damit alles lädt
      await page.waitForTimeout(3000);

      // Automatisches Verlassen nach konfigurierter Zeit
      if (config.autoLeaveAfter && config.autoLeaveAfter > 0) {
        console.log(`Bot ${index + 1} (${botName}): Wird die Konferenz in ${config.autoLeaveAfter}ms verlassen`);
        
        setTimeout(async () => {
          try {
            await leaveConference(page, botName, index + 1, browser);
          } catch (err) {
            console.error(`Bot ${index + 1} (${botName}): Fehler beim Verlassen der Konferenz: ${err.message}`);
          }
        }, config.autoLeaveAfter);
      }

    } catch (err) {
      console.error(`Bot ${index + 1} (${botName}): Fehler: ${err.message}`);
      await browser.close();
    }
  }

  // Funktion zum Verlassen der Konferenz
  async function leaveConference(page, botName, botIndex, browser) {
    try {
      debug(`Bot ${botIndex} (${botName}): Versuche Konferenz zu verlassen...`);
      
      // Ersten Button klicken (Hangup-Button in der Toolbar)
      const hangupButton = '#new-toolbox > div > div > div > div:nth-child(10) > div > div';
      await page.waitForSelector(hangupButton, { timeout: 5000 });
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
      
      // Noch eine kurze Pause vor dem Klick
      await page.waitForTimeout(500);
      
      await page.click(confirmButton);
      debug(`Bot ${botIndex} (${botName}): Bestätigungs-Button geklickt`);
      
      console.log(`Bot ${botIndex} (${botName}): Hat die Konferenz erfolgreich verlassen`);
      
      // Kurz warten bevor die Seite geschlossen wird
      await page.waitForTimeout(1000);
      await page.close();
      
      // Browser schließen nach dem Verlassen
      await browser.close();
      
    } catch (err) {
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
      await browser.close();
      process.exit(0);
    });
    
    // Halte Prozess am Leben
    await new Promise(() => {});
  } else {
    // Schließe Browser nach der konfigurierten Laufzeit
    console.log(`Bots laufen für ${config.runtime || 60000}ms und werden dann automatisch beendet.`);
    await new Promise(resolve => setTimeout(resolve, config.runtime || 60000));
    await browser.close();
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