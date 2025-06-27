const { chromium } = require('playwright');
const fs = require('fs');
const path = require('path');

class BotManager {
  constructor() {
    this.bots = new Map(); // botId -> { browser, page, config }
    this.config = this.loadConfig();
    this.baseUrl = this.config.url.split('/').slice(0, -1).join('/'); // Basis-URL ohne Raum
  }

  loadConfig() {
    try {
      const config = require('./config.json');
      console.log('Konfiguration geladen für BotManager');
      return config;
    } catch (err) {
      console.error('Fehler beim Laden der config.json:', err.message);
      throw err;
    }
  }

  // Hilfsfunktion für Zeitstempel-Logging
  logWithTimestamp(message) {
    const timestamp = new Date().toISOString();
    console.log(`[${timestamp}] ${message}`);
  }

  // Debug-Hilfsfunktion
  debug(message) {
    if (this.config.debug) {
      console.log(`[DEBUG] ${message}`);
    }
  }

  // Bot zur Sitzung hinzufügen
  async joinBot(botId, roomName, withVideo = false) {
    try {
      // NEUE PRÜFUNG: Bot bereits aktiv?
      if (this.bots.has(botId)) {
        console.warn(`⚠️ Bot ${botId} ist bereits aktiv - schließe alte Instanz`);
        await this.closeBot(botId);
      }

      const botConfig = this.config.bots.find(bot => bot.id === botId);
      if (!botConfig) {
        throw new Error(`Bot mit ID ${botId} nicht in Konfiguration gefunden`);
      }

      this.logWithTimestamp(`Bot ${botId} (${botConfig.name}) tritt Raum "${roomName}" bei (Video: ${withVideo})`);

      // Erstelle Bot-Instanz
      const botInstance = await this.createBotInstance(botConfig, withVideo);
      
      // Zur Sitzung joinen
      const url = `${this.baseUrl}/${roomName}`;
      await this.joinRoom(botInstance, url, botConfig.name, withVideo);

      // Bot in Map speichern
      this.bots.set(botId, {
        ...botInstance,
        config: botConfig,
        roomName: roomName
      });

      this.logWithTimestamp(`Bot ${botId} erfolgreich Raum "${roomName}" beigetreten`);
      return true;
    } catch (error) {
      console.error(`Fehler beim Beitreten von Bot ${botId}:`, error.message);
      throw error;
    }
  }

  // Einzelnen Bot erstellen
  async createBotInstance(botConfig, withVideo) {
    const videoFile = path.resolve(path.join(__dirname, 'media', botConfig.mediaFolder, botConfig.videoFile));
    const audioFile = path.resolve(path.join(__dirname, 'media', botConfig.mediaFolder, botConfig.audioFile));

    // Prüfe, ob die Mediendateien existieren
    if (!fs.existsSync(videoFile)) {
      throw new Error(`Video-Datei nicht gefunden: ${videoFile}`);
    }
    if (botConfig.enableAudio && !fs.existsSync(audioFile)) {
      throw new Error(`Audio-Datei nicht gefunden: ${audioFile}`);
    }

    // Launch-Optionen basierend auf Bot-Konfiguration
    const baseArgs = [
      '--allow-file-access-from-files',
      '--autoplay-policy=no-user-gesture-required',
      '--disable-web-security',
      '--ignore-certificate-errors'
    ];

    const launchOptions = {
      headless: this.config.headless === true,
      args: [...baseArgs],
      ignoreHTTPSErrors: true
    };

    // Audio-spezifische Argumente
    if (botConfig.enableAudio) {
      launchOptions.args.push(
        '--auto-accept-camera-and-microphone-capture',
        '--use-fake-device-for-media-stream'
      );
      
      if (withVideo) {
        launchOptions.args.push(`--use-file-for-fake-video-capture=${videoFile}`);
      }
      
      launchOptions.args.push(`--use-file-for-fake-audio-capture=${audioFile}`);
    } else {
      launchOptions.args.push(
        '--auto-accept-camera-and-microphone-capture',
        '--use-fake-device-for-media-stream'
      );
      
      if (withVideo) {
        launchOptions.args.push(`--use-file-for-fake-video-capture=${videoFile}`);
      }
      
      launchOptions.args.push(
        '--disable-features=VizDisplayCompositor',
        '--mute-audio'
      );
    }

    const browser = await chromium.launch(launchOptions);
    
    // Berechtigungen
    const permissions = [];
    if (withVideo) {
      permissions.push('camera');
    }
    permissions.push('microphone');
    
    const context = await browser.newContext({
      viewport: { width: 1280, height: 720 },
      permissions: permissions,
      ignoreHTTPSErrors: true
    });

    if (permissions.length > 0) {
      await context.grantPermissions(permissions);
    }

    const page = await context.newPage();

    return { browser, page, context };
  }

  // Bot zu Raum hinzufügen
  async joinRoom(botInstance, url, botName, withVideo) {
    const { page } = botInstance;

    try {
      this.debug(`Navigiere zu: ${url}`);
      await page.goto(url, { 
        timeout: 60000,
        waitUntil: 'domcontentloaded'
      });
      
      // Warte auf Namensfeld (Logik aus index.js)
      const nameField = 'div.premeeting-screen input';
      this.debug(`Warte auf Namensfeld: ${nameField}`);
      await page.waitForSelector(nameField, { timeout: 15000 });
      await page.fill(nameField, botName);
      this.debug(`Name "${botName}" wurde in das Feld eingegeben`);
      
      // NEUE LOGIK: Video in der UI deaktivieren, falls gewünscht
      if (!withVideo) {
        this.logWithTimestamp(`Video soll für Bot "${botName}" deaktiviert sein. Prüfe den Zustand der Kamera in der UI.`);
        try {
          // Robuster Selektor: findet den Button, egal ob an- oder ausgeschaltet, indem er nach dem Wort "Kamera" im Label sucht.
          const cameraButtonSelector = 'div[role="button"][aria-label*="Kamera"]';
          const cameraButton = await page.waitForSelector(cameraButtonSelector, { timeout: 5000 });
          
          // Prüfen, ob die Kamera aktiv ist. aria-pressed="false" bedeutet AN.
          const isCameraActive = await cameraButton.getAttribute('aria-pressed');
          
          if (isCameraActive === 'false') {
              this.logWithTimestamp(`Kamera für Bot "${botName}" ist aktiv. Deaktiviere sie jetzt.`);
              await cameraButton.click();
              this.debug(`Kamera für Bot "${botName}" wurde in der UI deaktiviert.`);
          } else {
              // aria-pressed ist 'true', die Kamera ist also bereits aus.
              this.logWithTimestamp(`Kamera für Bot "${botName}" ist bereits wie gewünscht deaktiviert.`);
          }
        } catch (error) {
          // Wenn wir nicht einmal einen Button mit "Kamera" im Label finden, stimmt etwas mit der Seite nicht.
          this.logWithTimestamp(`[WARNUNG] Konnte den Kamera-Button für Bot "${botName}" nicht finden. Fährt ohne Video-Aktion fort.`);
        }
      }
      
      // Join-Button (Logik aus index.js) 
      const joinButton = 'div[data-testid="prejoin.joinMeeting"]';
      this.debug(`Warte auf Join-Button: ${joinButton}`);
      await page.waitForSelector(joinButton, { timeout: 10000 });
      
      this.debug(`Klicke jetzt auf den Join-Button für Bot "${botName}"`);
      await page.click(joinButton);
      
      // Stabile Wartezeit nach dem Klick (Logik aus index.js)
      this.debug('Warte 3 Sekunden, bis der Beitritt abgeschlossen ist');
      await page.waitForTimeout(3000);
      
      // KORRIGIERTE LOGIK: Explizit stummschalten, falls Mikrofon bei Beitritt aktiv ist
      this.debug(`Prüfe Mikrofonstatus für Bot "${botName}" nach Beitritt`);
      const micButtonSelector = 'div[data-testid="toolbox.audioToggle"]';
      const micButton = await page.waitForSelector(micButtonSelector, { timeout: 10000 });
      
      // Laut Ihrer Analyse: 'aria-pressed="false"' bedeutet, das Mikrofon ist AN.
      const isMicActive = await micButton.getAttribute('aria-pressed');
      
      if (isMicActive === 'false') {
        this.logWithTimestamp(`Mikrofon für Bot "${botName}" ist bei Beitritt aktiv (aria-pressed="false"). Schalte es jetzt stumm.`);
        await page.click(micButtonSelector);
      } else {
        // isMicActive ist 'true', also bereits stumm.
        this.debug(`Mikrofon für Bot "${botName}" ist bereits wie gewünscht stumm (aria-pressed="true").`);
      }

      this.logWithTimestamp(`Bot ${botName} ist der Sitzung erfolgreich beigetreten und der Mikrofonstatus wurde sichergestellt.`);
    } catch (error) {
      console.error(`[FEHLER] Bot ${botName} konnte nicht beitreten: ${error.message}`);
      // Screenshot bei Fehler für besseres Debugging
      const screenshotPath = `reports/fehler-beitritt-${botName}.png`;
      await page.screenshot({ path: screenshotPath });
      console.error(`[DEBUG] Screenshot wurde unter ${screenshotPath} gespeichert.`);
      throw new Error(`Fehler beim Beitreten zur Sitzung für ${botName}: ${error.message}`);
    }
  }

  // Audio für einen Bot starten
  async startAudioForBot(botId) {
    const bot = this.bots.get(botId);
    if (!bot) {
      throw new Error(`Bot ${botId} nicht gefunden`);
    }

    if (!bot.config.enableAudio) {
      console.warn(`Bot ${botId} hat Audio nicht aktiviert`);
      return false;
    }

    try {
      this.logWithTimestamp(`Starte Audio für Bot ${botId}`);
      
      // Mikrofon-Button finden und klicken
      await bot.page.click('[data-testid="toolbox.audioToggle"]');
      
      this.logWithTimestamp(`Audio für Bot ${botId} gestartet`);
      return true;
    } catch (error) {
      console.error(`Fehler beim Starten von Audio für Bot ${botId}:`, error.message);
      throw error;
    }
  }

  // Audio für mehrere Bots simultan starten
  async startAudioForBots(botIds) {
    this.logWithTimestamp(`Starte Audio simultan für Bots: ${botIds.join(', ')}`);
    
    const promises = botIds.map(async (botId) => {
      try {
        await this.startAudioForBot(botId);
        return { botId, success: true };
      } catch (error) {
        console.error(`Fehler bei Bot ${botId}:`, error.message);
        return { botId, success: false, error: error.message };
      }
    });

    const results = await Promise.all(promises);
    
    const successful = results.filter(r => r.success).map(r => r.botId);
    const failed = results.filter(r => !r.success);

    this.logWithTimestamp(`Audio gestartet für Bots: ${successful.join(', ')}`);
    if (failed.length > 0) {
      console.warn(`Fehler bei Bots: ${failed.map(f => `${f.botId} (${f.error})`).join(', ')}`);
    }

    return { successful, failed };
  }

  // Warten
  async wait(seconds) {
    this.logWithTimestamp(`Warte ${seconds} Sekunden...`);
    await new Promise(resolve => setTimeout(resolve, seconds * 1000));
  }

  // Alle Bots schließen
  async closeAllBots() {
    this.logWithTimestamp('Schließe alle Bots...');
    
    const promises = Array.from(this.bots.entries()).map(async ([botId, bot]) => {
      try {
        await bot.browser.close();
        this.logWithTimestamp(`Bot ${botId} geschlossen`);
      } catch (error) {
        console.error(`Fehler beim Schließen von Bot ${botId}:`, error.message);
      }
    });

    await Promise.all(promises);
    this.bots.clear();
    this.logWithTimestamp('Alle Bots geschlossen');
  }

  // Einzelnen Bot schließen
  async closeBot(botId) {
    const bot = this.bots.get(botId);
    if (!bot) {
      console.warn(`Bot ${botId} nicht gefunden`);
      return;
    }

    try {
      await bot.browser.close();
      this.bots.delete(botId);
      this.logWithTimestamp(`Bot ${botId} geschlossen`);
    } catch (error) {
      console.error(`Fehler beim Schließen von Bot ${botId}:`, error.message);
    }
  }

  // Aktive Bots abrufen
  getActiveBots() {
    return Array.from(this.bots.keys());
  }

  // Bot-Status prüfen
  isBotActive(botId) {
    return this.bots.has(botId);
  }

  // Audio-Status prüfen (vereinfacht)
  async isAudioActive(botId) {
    const bot = this.bots.get(botId);
    if (!bot) {
      return false;
    }

    try {
      // Prüfe, ob Mikrofon-Button aktiv ist
      const muteButton = await bot.page.$('[data-testid="toolbox.audioToggle"]');
      const isActive = await muteButton?.getAttribute('aria-pressed') === 'true';
      return isActive;
    } catch (error) {
      console.error(`Fehler beim Prüfen des Audio-Status von Bot ${botId}:`, error.message);
      return false;
    }
  }
}

module.exports = BotManager; 