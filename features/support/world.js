const { setWorldConstructor, Before, After, BeforeAll, AfterAll, setDefaultTimeout } = require('@cucumber/cucumber');
const BotManager = require('../../bot-manager');

// Timeout für alle Steps auf 90 Sekunden erhöhen (muss höher sein als die längste Wartezeit)
setDefaultTimeout(180 * 1000);

class JitsiBotWorld {
  constructor() {
    this.botManager = new BotManager();
    this.testResults = {
      audioStarted: new Set(),
      errors: []
    };
  }

  // Bot beitreten lassen
  async joinBot(botId, roomName, withVideo = false) {
    try {
      await this.botManager.joinBot(botId, roomName, withVideo);
      console.log(`✓ Bot ${botId} erfolgreich Raum "${roomName}" beigetreten (Video: ${withVideo})`);
    } catch (error) {
      console.error(`✗ Fehler beim Beitreten von Bot ${botId}:`, error.message);
      this.testResults.errors.push(`Bot ${botId}: ${error.message}`);
      throw error;
    }
  }

  // Bot schnell beitreten lassen (ohne Mikrofon/Video-Checks)
  async quickJoinBot(botId, roomName) {
    try {
      await this.botManager.quickJoinBot(botId, roomName);
      console.log(`✓ Bot ${botId} erfolgreich Quick Beitritt zu Raum "${roomName}"`);
    } catch (error) {
      console.error(`✗ Fehler beim Quick Beitritt von Bot ${botId}:`, error.message);
      this.testResults.errors.push(`Bot ${botId}: ${error.message}`);
      throw error;
    }
  }

  // Audio für einen Bot starten
  async startAudioForBot(botId) {
    try {
      const success = await this.botManager.startAudioForBot(botId);
      if (success) {
        this.testResults.audioStarted.add(botId);
        console.log(`✓ Audio für Bot ${botId} gestartet`);
      } else {
        console.warn(`⚠ Audio für Bot ${botId} konnte nicht gestartet werden`);
      }
      return success;
    } catch (error) {
      console.error(`✗ Fehler beim Starten von Audio für Bot ${botId}:`, error.message);
      this.testResults.errors.push(`Bot ${botId} Audio: ${error.message}`);
      throw error;
    }
  }

  // Audio für mehrere Bots simultan starten
  async startAudioForBots(botIds) {
    try {
      const results = await this.botManager.startAudioForBots(botIds);
      
      // Ergebnisse verfolgen
      results.successful.forEach(botId => {
        this.testResults.audioStarted.add(botId);
      });
      
      results.failed.forEach(result => {
        this.testResults.errors.push(`Bot ${result.botId} Audio: ${result.error}`);
      });

      console.log(`✓ Audio simultan gestartet für ${results.successful.length}/${botIds.length} Bots`);
      
      if (results.failed.length > 0) {
        console.warn(`⚠ Audio-Start fehlgeschlagen für Bots: ${results.failed.map(f => f.botId).join(', ')}`);
      }

      return results;
    } catch (error) {
      console.error(`✗ Fehler beim simultanen Audio-Start:`, error.message);
      this.testResults.errors.push(`Simultaner Audio-Start: ${error.message}`);
      throw error;
    }
  }

  // Warten
  async wait(seconds) {
    await this.botManager.wait(seconds);
  }

  // Prüfe ob Bot aktiv ist
  isBotActive(botId) {
    return this.botManager.isBotActive(botId);
  }

  // Prüfe ob Bot Audio hat
  async isBotAudioActive(botId) {
    return await this.botManager.isAudioActive(botId);
  }

  // Aktive Bots abrufen
  getActiveBots() {
    return this.botManager.getActiveBots();
  }

  // Test-Ergebnisse abrufen
  getTestResults() {
    return {
      ...this.testResults,
      audioStartedBots: Array.from(this.testResults.audioStarted),
      hasErrors: this.testResults.errors.length > 0
    };
  }

  // Aufräumen
  async cleanup() {
    try {
      await this.botManager.closeAllBots();
      console.log('✓ Alle Bots erfolgreich geschlossen');
    } catch (error) {
      console.error('✗ Fehler beim Schließen der Bots:', error.message);
    }
  }

  // Bot stummschalten
  async muteBot(botId) {
    await this.botManager.setMuteForBot(botId, true);
  }

  // Stummschaltung für Bot aufheben
  async unmuteBot(botId) {
    await this.botManager.setMuteForBot(botId, false);
  }

  // Taste M für Bot drücken
  async pressMKey(botId) {
    try {
      await this.botManager.pressMKeyForBot(botId);
      console.log(`✓ Bot ${botId} hat Taste M gedrückt`);
    } catch (error) {
      console.error(`✗ Fehler beim Drücken der Taste M für Bot ${botId}:`, error.message);
      this.testResults.errors.push(`Bot ${botId} Taste M: ${error.message}`);
      throw error;
    }
  }

  // Debug-Breakpoint setzen
  async setDebugBreakpoint(message) {
    try {
      await this.botManager.setDebugBreakpoint(message);
      
      // Debug-Informationen ausgeben
      const debugInfo = this.botManager.getAllBotsDebugInfo();
      console.log('🔍 Bot Debug-Informationen:', JSON.stringify(debugInfo, null, 2));
      
    } catch (error) {
      console.error(`✗ Fehler beim Debug-Breakpoint:`, error.message);
      this.testResults.errors.push(`Debug: ${error.message}`);
      throw error;
    }
  }
}

// World Constructor setzen
setWorldConstructor(JitsiBotWorld);

// Hooks für Setup und Teardown
BeforeAll(async function() {
  console.log('🚀 Starte Cucumber-Tests für Jitsi-Bots...');
  
  // Erstelle reports Verzeichnis falls nicht vorhanden
  const fs = require('fs');
  if (!fs.existsSync('reports')) {
    fs.mkdirSync('reports');
  }
});

Before(async function(scenario) {
  console.log(`\n📋 Starte Szenario: ${scenario.pickle.name}`);
  this.scenarioStartTime = Date.now();
});

After(async function(scenario) {
  const duration = (Date.now() - this.scenarioStartTime) / 1000;
  
  if (scenario.result.status === 'PASSED') {
    console.log(`✅ Szenario erfolgreich abgeschlossen in ${duration.toFixed(2)}s`);
  } else {
    console.log(`❌ Szenario fehlgeschlagen in ${duration.toFixed(2)}s`);
    
    // Test-Ergebnisse bei Fehlern ausgeben
    const results = this.getTestResults();
    if (results.hasErrors) {
      console.log('🔍 Fehlerdetails:');
      results.errors.forEach(error => console.log(`  - ${error}`));
    }
  }

  // Cleanup nach jedem Szenario
  await this.cleanup();
});

AfterAll(async function() {
  console.log('🏁 Alle Cucumber-Tests abgeschlossen');
});

module.exports = JitsiBotWorld; 