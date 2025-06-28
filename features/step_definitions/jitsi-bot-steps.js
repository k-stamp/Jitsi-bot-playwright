const { Given, When } = require('@cucumber/cucumber');

// Hilfsfunktionen
function parseBotsString(botsString) {
  return botsString.split(',').map(id => parseInt(id.trim()));
}

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

When('Bot {int} schaltet sich stumm', async function(botId) {
  await this.muteBot(botId);
});

When('Bot {int} hebt die Stummschaltung auf', async function(botId) {
  await this.unmuteBot(botId);
});

When('warte {int} Sekunden', async function(seconds) {
  await this.wait(seconds);
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