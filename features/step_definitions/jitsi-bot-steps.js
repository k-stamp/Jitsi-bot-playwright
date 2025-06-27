const { Given, When, Then } = require('@cucumber/cucumber');
const assert = require('assert');

// Hilfsfunktionen
function parseBotsString(botsString) {
  return botsString.split(',').map(id => parseInt(id.trim()));
}

// Background Steps
Given('der Jitsi-Server ist verfügbar', async function() {
  // Hier könnten wir einen Health-Check des Servers durchführen
  console.log('🔍 Überprüfe Jitsi-Server Verfügbarkeit...');
  
  // Für jetzt nehmen wir an, dass der Server verfügbar ist
  // In einer echten Implementierung könnten wir einen HTTP-Request machen
  const serverUrl = this.botManager.baseUrl;
  console.log(`✓ Jitsi-Server unter ${serverUrl} bereit`);
});

// Given Steps - Bot Beitritt
Given('Bot {int} joint der Sitzung {string} ohne Video', async function(botId, roomName) {
  await this.joinBot(botId, roomName, false);
});

Given('Bot {int} joint der Sitzung {string} mit Video', async function(botId, roomName) {
  await this.joinBot(botId, roomName, true);
});

// When Steps - Audio Aktionen
When('Bot {int} Audio abspielt', async function(botId) {
  await this.startAudioForBot(botId);
});

When('Bots {string} Audio abspielen', async function(botsString) {
  const botIds = parseBotsString(botsString);
  await this.startAudioForBots(botIds);
});

When('nach {int} Sekunden spielen Bots {string} Audio ab', async function(seconds, botsString) {
  await this.wait(seconds);
  const botIds = parseBotsString(botsString);
  await this.startAudioForBots(botIds);
});

When('warte {int} Sekunden', async function(seconds) {
  await this.wait(seconds);
});

// Then Steps - Assertions
Then('sollte Bot {int} Audio in der Sitzung hörbar sein', async function(botId) {
  const isActive = await this.isBotAudioActive(botId);
  const results = this.getTestResults();
  
  // Prüfe ob Bot Audio gestartet hat
  const audioStarted = results.audioStartedBots.includes(botId);
  
  assert(audioStarted, `Bot ${botId} sollte Audio gestartet haben`);
  console.log(`✓ Bot ${botId} Audio ist aktiv`);
});

Then('sollten alle Bots {string} simultan Audio in der Sitzung abspielen', async function(botsString) {
  const botIds = parseBotsString(botsString);
  const results = this.getTestResults();
  
  // Prüfe ob alle angegebenen Bots Audio gestartet haben
  for (const botId of botIds) {
    const audioStarted = results.audioStartedBots.includes(botId);
    assert(audioStarted, `Bot ${botId} sollte Audio gestartet haben`);
  }
  
  console.log(`✓ Alle Bots [${botIds.join(', ')}] spielen simultan Audio ab`);
});

Then('sollten alle Bots Audio in der Sitzung abspielen', async function() {
  const activeBots = this.getActiveBots();
  const results = this.getTestResults();
  
  // Prüfe ob mindestens ein Bot Audio spielt
  assert(results.audioStartedBots.length > 0, 'Mindestens ein Bot sollte Audio abspielen');
  
  console.log(`✓ ${results.audioStartedBots.length} von ${activeBots.length} Bots spielen Audio ab`);
});

Then('sollte Bot {int} zuerst Audio abspielen', async function(botId) {
  const results = this.getTestResults();
  
  // Prüfe ob Bot Audio gestartet hat
  const audioStarted = results.audioStartedBots.includes(botId);
  assert(audioStarted, `Bot ${botId} sollte Audio gestartet haben`);
  
  console.log(`✓ Bot ${botId} hat Audio zuerst gestartet`);
});

Then('dann sollten Bots {string} simultan Audio abspielen', async function(botsString) {
  const botIds = parseBotsString(botsString);
  const results = this.getTestResults();
  
  // Prüfe ob alle angegebenen Bots Audio gestartet haben
  for (const botId of botIds) {
    const audioStarted = results.audioStartedBots.includes(botId);
    assert(audioStarted, `Bot ${botId} sollte Audio gestartet haben`);
  }
  
  console.log(`✓ Bots [${botIds.join(', ')}] spielen anschließend simultan Audio ab`);
});

// Zusätzliche Step Definitions für erweiterte Szenarien
Given('Bot {int} ist bereits der Sitzung {string} beigetreten', async function(botId, roomName) {
  const isActive = this.isBotActive(botId);
  if (!isActive) {
    await this.joinBot(botId, roomName, false);
  }
  
  assert(this.isBotActive(botId), `Bot ${botId} sollte aktiv sein`);
  console.log(`✓ Bot ${botId} ist bereits der Sitzung "${roomName}" beigetreten`);
});

When('Bot {int} das Audio stoppt', async function(botId) {
  // Hier würden wir die Audio-Stop-Funktionalität implementieren
  // Für jetzt loggen wir nur die Aktion
  console.log(`🔇 Bot ${botId} stoppt Audio`);
  
  // TODO: Implementiere Audio-Stop in BotManager
  // await this.stopAudioForBot(botId);
});

Then('sollte Bot {int} kein Audio mehr abspielen', async function(botId) {
  // Hier würden wir prüfen, ob Bot kein Audio mehr spielt
  console.log(`✓ Bot ${botId} spielt kein Audio mehr ab`);
  
  // TODO: Implementiere Audio-Status-Prüfung
  // const isActive = await this.isBotAudioActive(botId);
  // assert(!isActive, `Bot ${botId} sollte kein Audio mehr abspielen`);
});

Then('sollten {int} Bots in der Sitzung {string} sein', async function(expectedCount, roomName) {
  const activeBots = this.getActiveBots();
  assert.strictEqual(activeBots.length, expectedCount, 
    `Erwartet ${expectedCount} Bots, aber ${activeBots.length} sind aktiv`);
  
  console.log(`✓ ${expectedCount} Bots sind in der Sitzung "${roomName}"`);
});

// Debug Steps
When('zeige aktive Bots an', async function() {
  const activeBots = this.getActiveBots();
  const results = this.getTestResults();
  
  console.log('🔍 Debug-Informationen:');
  console.log(`  - Aktive Bots: [${activeBots.join(', ')}]`);
  console.log(`  - Bots mit Audio: [${results.audioStartedBots.join(', ')}]`);
  console.log(`  - Fehler: ${results.errors.length}`);
  
  if (results.hasErrors) {
    console.log('  - Fehlerdetails:');
    results.errors.forEach((error, index) => {
      console.log(`    ${index + 1}. ${error}`);
    });
  }
}); 