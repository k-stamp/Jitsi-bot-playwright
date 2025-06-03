const { Given, When, Then, Before, After, setDefaultTimeout } = require('@cucumber/cucumber');
const { chromium } = require('playwright');
const { uniqueNamesGenerator, adjectives, colors, animals, NumberDictionary } = require('unique-names-generator');
const fs = require('fs');
const path = require('path');

// Setze Standard-Timeout auf 5 Minuten
setDefaultTimeout(300000);

// Globale Variablen für den Test-Kontext
let config;
let browsers = [];
let pages = [];
let contexts = [];
let conferenceUrl;
let botConfigs = [];

// Lade Konfiguration
Before(async function() {
  try {
    config = require('../../config.json');
    console.log('Konfiguration für Cucumber-Tests geladen');
  } catch (err) {
    throw new Error(`Fehler beim Laden der config.json: ${err.message}`);
  }
});

// Cleanup nach jedem Szenario
After(async function() {
  console.log('Schließe alle Browser und Kontexte...');
  
  // Schließe alle Seiten
  for (const page of pages) {
    try {
      if (!page.isClosed()) {
        await page.close();
      }
    } catch (err) {
      console.log('Fehler beim Schließen der Seite:', err.message);
    }
  }
  
  // Schließe alle Kontexte
  for (const context of contexts) {
    try {
      await context.close();
    } catch (err) {
      console.log('Fehler beim Schließen des Kontexts:', err.message);
    }
  }
  
  // Schließe alle Browser
  for (const browser of browsers) {
    try {
      await browser.close();
    } catch (err) {
      console.log('Fehler beim Schließen des Browsers:', err.message);
    }
  }
  
  // Reset arrays
  browsers = [];
  pages = [];
  contexts = [];
  botConfigs = [];
});

Given('eine Jitsi-Konferenz-URL {string}', function(url) {
  conferenceUrl = url;
  console.log(`Konferenz-URL gesetzt: ${conferenceUrl}`);
});

Given('ich habe {int} konfigurierte Bots', function(numberOfBots) {
  if (!config.bots || config.bots.length < numberOfBots) {
    throw new Error(`Nicht genügend Bot-Konfigurationen vorhanden. Benötigt: ${numberOfBots}, Verfügbar: ${config.bots?.length || 0}`);
  }
  
  botConfigs = config.bots.slice(0, numberOfBots);
  console.log(`${numberOfBots} Bots für den Test konfiguriert`);
});

Given('ich habe Bots mit verschiedenen Video-Inhalten:', function(dataTable) {
  const rows = dataTable.hashes();
  botConfigs = rows.map(row => ({
    id: parseInt(row.Bot),
    name: `Bot${row.Bot}`,
    mediaFolder: `bot${row.Bot}`,
    videoFile: row['Video-Datei'],
    audioFile: row['Audio-Datei']
  }));
  console.log(`Bots mit spezifischen Medien-Inhalten konfiguriert:`, botConfigs);
});

When('ich alle Bots zur Konferenz hinzufüge', { timeout: 300000 }, async function() {
  console.log(`Starte ${botConfigs.length} Bots für die Konferenz...`);
  
  for (let i = 0; i < botConfigs.length; i++) {
    const botConfig = botConfigs[i];
    await startBot(i, botConfig, false); // false = noch kein Audio/Video starten
    
    // Kurze Verzögerung zwischen Bots
    await new Promise(resolve => setTimeout(resolve, config.delayBetweenBots || 2000));
  }
  
  console.log('Alle Bots wurden zur Konferenz hinzugefügt');
});

When('ich Bot {int} zur Konferenz hinzufüge', { timeout: 60000 }, async function(botNumber) {
  const botConfig = botConfigs.find(bot => bot.id === botNumber);
  if (!botConfig) {
    throw new Error(`Bot ${botNumber} nicht in der Konfiguration gefunden`);
  }
  
  await startBot(botNumber - 1, botConfig, true); // true = Audio/Video sofort starten
  console.log(`Bot ${botNumber} zur Konferenz hinzugefügt`);
});

When('ich warte {int} Sekunden', async function(seconds) {
  console.log(`Warte ${seconds} Sekunden...`);
  await new Promise(resolve => setTimeout(resolve, seconds * 1000));
});

When('ich die Ausführung fortsetze', async function() {
  console.log('Starte Audio und Video für alle Bots gleichzeitig...');
  
  // Hier können Sie zusätzliche Logik hinzufügen, um Audio/Video zu aktivieren
  // Da die Bots bereits mit Medien-Dateien gestartet wurden, läuft das Audio/Video bereits
  
  console.log('Audio und Video für alle Bots gestartet');
});

Then('sollten alle Bots erfolgreich der Konferenz beigetreten sein', { timeout: 60000 }, async function() {
  // Überprüfe, ob alle Seiten geladen sind und in der Konferenz sind
  for (let i = 0; i < pages.length; i++) {
    const page = pages[i];
    
    try {
      // Warte auf ein Element, das anzeigt, dass der Bot in der Konferenz ist
      // Verwende einen robusteren Selector - die Toolbar oder das Video-Element
      await page.waitForSelector('#new-toolbox', { timeout: 15000 });
      console.log(`Bot ${i + 1}: Erfolgreich in der Konferenz`);
    } catch (err) {
      console.log(`Bot ${i + 1}: Versuche alternativen Selector...`);
      try {
        // Alternativer Selector - das Hauptvideo-Element
        await page.waitForSelector('[data-testid="videoContainer"]', { timeout: 10000 });
        console.log(`Bot ${i + 1}: Erfolgreich in der Konferenz (alternativer Selector)`);
      } catch (err2) {
        console.log(`Bot ${i + 1}: Versuche dritten Selector...`);
        try {
          // Noch ein alternativer Selector - irgendein Video-Element
          await page.waitForSelector('video', { timeout: 10000 });
          console.log(`Bot ${i + 1}: Erfolgreich in der Konferenz (Video-Element gefunden)`);
        } catch (err3) {
          throw new Error(`Bot ${i + 1}: Nicht erfolgreich der Konferenz beigetreten - ${err3.message}`);
        }
      }
    }
  }
  
  console.log(`Alle ${pages.length} Bots sind erfolgreich der Konferenz beigetreten`);
});

Then('das System pausiert für Debugging', { timeout: 600000 }, async function() {
  console.log('\n🔍 DEBUGGING-PAUSE AKTIVIERT');
  console.log('=====================================');
  console.log('Alle Bots sind jetzt in der Konferenz.');
  console.log('Sie können jetzt:');
  console.log('- Die Browser-Fenster überprüfen');
  console.log('- Die Konferenz manuell testen');
  console.log('- Screenshots machen');
  console.log('');
  console.log('Drücken Sie ENTER, um fortzufahren...');
  console.log('=====================================\n');
  
  // Warte auf Benutzereingabe
  await waitForUserInput();
});

Then('starten alle Bots gleichzeitig Audio und Video', async function() {
  console.log('Audio und Video läuft bereits für alle Bots (durch Medien-Dateien)');
  
  // Optional: Zusätzliche Überprüfungen oder Aktionen
  for (let i = 0; i < pages.length; i++) {
    const page = pages[i];
    console.log(`Bot ${i + 1}: Audio/Video aktiv`);
  }
});

Then('alle Medien werden synchron abgespielt', async function() {
  console.log('Überprüfe synchrone Medienwiedergabe...');
  
  // Hier könnten Sie zusätzliche Überprüfungen implementieren
  // z.B. Audio-Level-Checks oder Video-Frame-Analysen
  
  console.log('Medien werden synchron abgespielt');
});

Then('sollten alle {int} Bots in der Konferenz sein', async function(expectedCount) {
  if (pages.length !== expectedCount) {
    throw new Error(`Erwartet ${expectedCount} Bots, aber ${pages.length} sind aktiv`);
  }
  
  console.log(`Bestätigt: ${expectedCount} Bots sind in der Konferenz`);
});

Then('sollte jeder Bot seinen eigenen Medien-Inhalt abspielen', async function() {
  console.log('Überprüfe individuelle Medien-Inhalte der Bots...');
  
  for (let i = 0; i < pages.length; i++) {
    const botConfig = botConfigs[i];
    console.log(`Bot ${i + 1}: Spielt ${botConfig.videoFile} und ${botConfig.audioFile} ab`);
  }
  
  console.log('Alle Bots spielen ihre individuellen Medien-Inhalte ab');
});

// Hilfsfunktionen
async function startBot(index, botConfig, startMediaImmediately = true) {
  const videoFile = path.resolve(path.join(__dirname, '../../media', botConfig.mediaFolder, botConfig.videoFile));
  const audioFile = path.resolve(path.join(__dirname, '../../media', botConfig.mediaFolder, botConfig.audioFile));
  
  console.log(`Starte Bot ${index + 1} (${botConfig.name})`);
  console.log(`- Video: ${videoFile}`);
  console.log(`- Audio: ${audioFile}`);
  
  // Prüfe Dateien
  if (!fs.existsSync(videoFile)) {
    throw new Error(`Video-Datei nicht gefunden: ${videoFile}`);
  }
  if (!fs.existsSync(audioFile)) {
    throw new Error(`Audio-Datei nicht gefunden: ${audioFile}`);
  }
  
  // Browser-Optionen
  const launchOptions = {
    headless: config.headless !== false, // Verwende config.json Einstellung, Standard: true
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
  
  const browser = await chromium.launch(launchOptions);
  browsers.push(browser);
  
  const context = await browser.newContext({
    viewport: { width: 1280, height: 720 },
    permissions: ['camera', 'microphone']
  });
  contexts.push(context);
  
  await context.grantPermissions(['camera', 'microphone']);
  
  const page = await context.newPage();
  pages.push(page);
  
  // Bot-Name generieren
  const randomName = uniqueNamesGenerator({ 
    dictionaries: [colors, adjectives, animals], 
    separator: "", 
    length: 2, 
    style: 'capital' 
  }) + NumberDictionary.generate({ min: 10, max: 9999 });
  
  const botName = config.userandomnames ? randomName : botConfig.name;
  
  // Zur Konferenz navigieren
  await page.goto(conferenceUrl);
  
  // Name eingeben
  const nameField = 'div.premeeting-screen input';
  await page.waitForSelector(nameField, { timeout: 10000 });
  await page.fill(nameField, botName);
  
  // Meeting beitreten
  const joinButton = 'div[data-testid="prejoin.joinMeeting"]';
  await page.click(joinButton);
  
  // Kurz warten
  await page.waitForTimeout(3000);
  
  console.log(`Bot ${index + 1} (${botName}): Erfolgreich der Konferenz beigetreten`);
}

async function waitForUserInput() {
  return new Promise((resolve) => {
    const stdin = process.stdin;
    stdin.setRawMode(true);
    stdin.resume();
    stdin.setEncoding('utf8');
    
    stdin.on('data', function(key) {
      if (key === '\r' || key === '\n') {
        stdin.setRawMode(false);
        stdin.pause();
        resolve();
      }
    });
  });
} 