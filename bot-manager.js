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
      '--ignore-certificate-errors',
      '--disable-features=VizDisplayCompositor'
    ];

    // Zusätzliche Argumente für bessere Headless-Kompatibilität
    if (this.config.headless === true) {
      baseArgs.push(
        '--disable-gpu',
        '--disable-dev-shm-usage',
        '--disable-setuid-sandbox',
        '--no-first-run',
        '--no-sandbox',
        '--no-zygote',
        '--disable-background-timer-throttling',
        '--disable-backgrounding-occluded-windows',
        '--disable-renderer-backgrounding'
      );
    }

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
      
      // Warte etwas länger, damit die UI vollständig geladen ist (besonders wichtig im Headless-Modus)
      await page.waitForTimeout(2000);
      
      // NEUE LOGIK: Video in der UI deaktivieren, falls gewünscht
      if (!withVideo) {
        this.logWithTimestamp(`Video soll für Bot "${botName}" deaktiviert sein. Prüfe den Zustand der Kamera in der UI.`);
        await this.handleCameraButton(page, botName, false);
      }
      
      // NEUE LOGIK: Mikrofon in der UI immer deaktivieren
      this.logWithTimestamp(`Prüfe den Zustand des Mikrofons für Bot "${botName}" in der UI.`);
      await this.handleMicrophoneButton(page, botName, true);
      
      // Join-Button (Logik aus index.js) 
      const joinButton = 'div[data-testid="prejoin.joinMeeting"]';
      this.debug(`Warte auf Join-Button: ${joinButton}`);
      await page.waitForSelector(joinButton, { timeout: 10000 });
      
      this.debug(`Klicke jetzt auf den Join-Button für Bot "${botName}"`);
      await page.click(joinButton);
      
      // Stabile Wartezeit nach dem Klick (Logik aus index.js)
      this.debug('Warte 5 Sekunden, bis der Beitritt abgeschlossen ist und die UI geladen hat.');
      await page.waitForTimeout(5000);
      
      this.logWithTimestamp(`Bot ${botName} ist der Sitzung erfolgreich beigetreten.`);
    } catch (error) {
      console.error(`[FEHLER] Bot ${botName} konnte nicht beitreten: ${error.message}`);
      // Screenshot bei Fehler für besseres Debugging
      const screenshotPath = `reports/fehler-beitritt-${botName}.png`;
      await page.screenshot({ path: screenshotPath });
      console.error(`[DEBUG] Screenshot wurde unter ${screenshotPath} gespeichert.`);
      throw new Error(`Fehler beim Beitreten zur Sitzung für ${botName}: ${error.message}`);
    }
  }

  // Kamera-Button handhaben (robuste Methode für Headless-Modus)
  async handleCameraButton(page, botName, shouldBeEnabled) {
    const action = shouldBeEnabled ? 'aktivieren' : 'deaktivieren';
    
    try {
      // Mehrere Selektoren probieren, um robuster zu sein
      const cameraSelectors = [
        // Premeeting-Screen Selektoren
        'div[role="button"][aria-label*="Kamera"]',
        'div[role="button"][aria-label*="Camera"]',
        'button[aria-label*="Kamera"]',
        'button[aria-label*="Camera"]',
        // Hauptkonferenz-UI Selektoren
        '[data-testid="toolbox.videoToggle"]',
        '[data-testid="toolbox.video"]',
        '[data-testid="toolbar.video"]',
        '[data-testid="toolbar.videoToggle"]',
        '.toolbox-button[aria-label*="Camera"]',
        '.toolbox-button[aria-label*="Kamera"]',
        '.toolbox-button[aria-label*="Video"]',
        // Weitere generische Selektoren
        '[data-testid*="camera"]',
        '[data-testid*="video"]',
        'button[title*="Camera"]',
        'button[title*="Kamera"]',
        'button[title*="Video"]'
      ];

      let cameraButton = null;
      let totalTimeout = 0;
      const maxTotalTimeout = 15000; // Max 15 Sekunden für alle Kamera-Selektoren
      
      // Versuche verschiedene Selektoren mit Gesamttimeout-Begrenzung
      for (const selector of cameraSelectors) {
        if (totalTimeout >= maxTotalTimeout) {
          this.debug(`Gesamttimeout für Kamera-Button erreicht (${maxTotalTimeout}ms)`);
          break;
        }
        
        try {
          const startTime = Date.now();
          // Kürzere Timeouts für schnelleres Failover
          const timeout = selector.includes('toolbox') || selector.includes('toolbar') ? 3000 : 1500;
          cameraButton = await page.waitForSelector(selector, { timeout });
          if (cameraButton) {
            this.debug(`Kamera-Button mit Selektor "${selector}" gefunden`);
            break;
          }
        } catch (e) {
          totalTimeout += Date.now() - (Date.now() - (selector.includes('toolbox') || selector.includes('toolbar') ? 3000 : 1500));
          // Versuche nächsten Selektor
          continue;
        }
      }

      if (!cameraButton) {
        this.logWithTimestamp(`[WARNUNG] Konnte keinen Kamera-Button für Bot "${botName}" finden. Fährt ohne Video-Aktion fort.`);
        return;
      }

      // Warte kurz für UI-Stabilität im Headless-Modus
      await page.waitForTimeout(500);

      // Prüfen, ob bereits im gewünschten Zustand
      const isPressed = await cameraButton.getAttribute('aria-pressed');
      const isCurrentlyEnabled = isPressed === 'false'; // aria-pressed="false" bedeutet die Kamera ist AN

      if (shouldBeEnabled && !isCurrentlyEnabled) {
        this.logWithTimestamp(`Kamera für Bot "${botName}" ist aus. ${action}.`);
        await cameraButton.click();
        await page.waitForTimeout(500); // Warte nach Klick
        this.debug(`Kamera für Bot "${botName}" wurde aktiviert.`);
      } else if (!shouldBeEnabled && isCurrentlyEnabled) {
        this.logWithTimestamp(`Kamera für Bot "${botName}" ist an. ${action}.`);
        await cameraButton.click();
        await page.waitForTimeout(500); // Warte nach Klick
        this.debug(`Kamera für Bot "${botName}" wurde deaktiviert.`);
      } else {
        this.logWithTimestamp(`Kamera für Bot "${botName}" ist bereits wie gewünscht ${isCurrentlyEnabled ? 'aktiviert' : 'deaktiviert'}.`);
      }
    } catch (error) {
      this.logWithTimestamp(`[WARNUNG] Fehler beim ${action} der Kamera für Bot "${botName}": ${error.message}`);
    }
  }

  // Mikrofon-Button handhaben (robuste Methode für Headless-Modus)
  async handleMicrophoneButton(page, botName, shouldBeMuted, throwOnError = false) {
    const action = shouldBeMuted ? 'stummschalten' : 'Stummschaltung aufheben';
    
    try {
      // NEUE STRATEGIE: Zuerst Tastaturkürzel versuchen (ist zuverlässiger in der Hauptkonferenz)
      
      // Für Hauptkonferenz: Verwende direkt Tastaturkürzel
      const url = await page.url();
      const isInMainConference = !url.includes('prejoin') && url.includes('://');
      
      if (isInMainConference) {
        this.logWithTimestamp(`Bot "${botName}" ist in Hauptkonferenz, verwende Tastaturkürzel für ${action}`);
        try {
          // Aktiviere zunächst die Seite
          await page.click('body');
          await page.waitForTimeout(200);
          
          // Jitsi Meet verwendet 'm' als Tastaturkürzel für Mikrofon-Toggle
          await page.keyboard.press('m');
          await page.waitForTimeout(500);
          this.debug(`Tastaturkürzel 'm' für Mikrofon verwendet bei Bot "${botName}"`);
          this.logWithTimestamp(`${action} für Bot "${botName}" über Tastaturkürzel erfolgreich`);
          return; // Erfolgreich, beende die Methode
        } catch (keyboardError) {
          this.debug(`Tastaturkürzel fehlgeschlagen: ${keyboardError.message}, versuche Button-Suche`);
        }
      }
      
      // Fallback: Button-Suche (primär für Premeeting-Screen)
      const micSelectors = [
        // Premeeting-Screen Selektoren (höhere Priorität)
        'div[role="button"][aria-label*="Mikrofon"]',
        'div[role="button"][aria-label*="Mute"]',
        'div[role="button"][aria-label*="Stummschaltung"]',
        'div[role="button"][aria-label*="Microphone"]',
        'button[aria-label*="Mikrofon"]',
        'button[aria-label*="Microphone"]',
        // Schnelle Hauptkonferenz-UI Selektoren
        '[data-testid="toolbox.audioToggle"]',
        '.toolbox-button[aria-label*="Mute"]',
        '#audioToggle'
      ];

      let micButton = null;
      
      // Kurze Toolbox-Aktivierung nur für Hauptkonferenz
      if (isInMainConference) {
        try {
          await page.mouse.move(640, 600);
          await page.waitForTimeout(500);
        } catch (e) {
          // Ignoriere Fehler
        }
      }
      
      // Versuche Selektoren mit kurzen Timeouts
      for (const selector of micSelectors) {
        try {
          const timeout = isInMainConference ? 1500 : 2000; // Kürzere Timeouts für Hauptkonferenz
          micButton = await page.waitForSelector(selector, { timeout });
          if (micButton) {
            this.debug(`Mikrofon-Button mit Selektor "${selector}" gefunden`);
            break;
          }
        } catch (e) {
          // Versuche nächsten Selektor
          continue;
        }
      }

      if (!micButton) {
        // Letzter Fallback: Tastaturkürzel (falls noch nicht versucht)
        if (!isInMainConference) {
          this.logWithTimestamp(`Konnte keinen Mikrofon-Button finden, versuche Tastaturkürzel für Bot "${botName}"`);
          try {
            await page.keyboard.press('m');
            await page.waitForTimeout(500);
            this.debug(`Tastaturkürzel 'm' für Mikrofon verwendet bei Bot "${botName}"`);
            return;
          } catch (keyboardError) {
            // Fall through zu Fehlerbehandlung
          }
        }
        
        const errorMsg = `Konnte keinen Mikrofon-Button für Bot "${botName}" finden`;
        if (throwOnError) {
          throw new Error(errorMsg);
        } else {
          this.logWithTimestamp(`[WARNUNG] ${errorMsg}. Fährt fort.`);
          return;
        }
      }

      // Warte kurz für UI-Stabilität im Headless-Modus
      await page.waitForTimeout(500);

      // Prüfen, ob bereits im gewünschten Zustand
      const isPressed = await micButton.getAttribute('aria-pressed');
      const isCurrentlyMuted = isPressed === 'true'; // aria-pressed="true" bedeutet das Mikrofon ist STUMM

      if (shouldBeMuted && !isCurrentlyMuted) {
        this.logWithTimestamp(`Mikrofon für Bot "${botName}" ist an. ${action}.`);
        await micButton.click();
        await page.waitForTimeout(500); // Warte nach Klick
        this.debug(`Mikrofon für Bot "${botName}" wurde stummgeschaltet.`);
      } else if (!shouldBeMuted && isCurrentlyMuted) {
        this.logWithTimestamp(`Mikrofon für Bot "${botName}" ist stumm. ${action}.`);
        await micButton.click();
        await page.waitForTimeout(500); // Warte nach Klick
        this.debug(`Stummschaltung für Bot "${botName}" wurde aufgehoben.`);
      } else {
        this.logWithTimestamp(`Mikrofon für Bot "${botName}" ist bereits wie gewünscht ${isCurrentlyMuted ? 'stummgeschaltet' : 'aktiviert'}.`);
      }
    } catch (error) {
      const errorMsg = `Fehler beim ${action} für Bot "${botName}": ${error.message}`;
      if (throwOnError) {
        throw new Error(errorMsg);
      } else {
        this.logWithTimestamp(`[WARNUNG] ${errorMsg}`);
      }
    }
  }

  // Mikrofon eines Bots stummschalten oder Stummschaltung aufheben
  async setMuteForBot(botId, shouldBeMuted) {
    const bot = this.bots.get(botId);
    if (!bot) {
      throw new Error(`Bot ${botId} nicht gefunden oder nicht aktiv.`);
    }

    const { page, config } = bot;
    const action = shouldBeMuted ? 'stummschalten' : 'Stummschaltung aufheben';
    this.logWithTimestamp(`Versuche, für Bot ${botId} die Aktion '${action}' auszuführen.`);

    try {
      await this.handleMicrophoneButton(page, config.name, shouldBeMuted, true);
    } catch (error) {
      const errorMessage = `Konnte den Mikrofon-Button für Bot ${botId} nicht umschalten: ${error.message}`;
      console.error(`[FEHLER] ${errorMessage}`);
      throw new Error(errorMessage);
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