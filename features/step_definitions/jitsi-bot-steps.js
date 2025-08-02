const { Given, When } = require('@cucumber/cucumber');

// Hilfsfunktionen
function parseBotsString(botsString) {
  return botsString.split(',').map(id => parseInt(id.trim()));
}

// Debug-Hilfsfunktion für Step-by-Step Debugging
async function waitForUserInput(stepDescription) {
  if (process.env.DEBUG_STEP_BY_STEP === 'true') {
    console.log(`\n🔄 NÄCHSTER STEP: ${stepDescription}`);
    console.log('👆 Drücke Enter um fortzufahren, oder "q" + Enter zum Beenden...');
    
    return new Promise((resolve) => {
      process.stdin.setRawMode(false);
      process.stdin.resume();
      process.stdin.once('data', (data) => {
        const input = data.toString().trim();
        if (input.toLowerCase() === 'q') {
          console.log('🛑 Debug-Session beendet');
          process.exit(0);
        }
        console.log('✅ Führe Step aus...\n');
        resolve();
      });
    });
  }
}

// Given Steps - Bot Beitritt
Given('Bot {int} joint der Sitzung {string} ohne Video', async function(botId, roomName) {
  await waitForUserInput(`Bot ${botId} joint der Sitzung "${roomName}" ohne Video`);
  await this.joinBot(botId, roomName, false);
});

Given('Bot {int} joint der Sitzung {string} mit Video', async function(botId, roomName) {
  await waitForUserInput(`Bot ${botId} joint der Sitzung "${roomName}" mit Video`);
  await this.joinBot(botId, roomName, true);
});

Given('Bot {int} macht einen Quick Beitritt zur Sitzung {string}', async function(botId, roomName) {
  await waitForUserInput(`Bot ${botId} macht einen Quick Beitritt zur Sitzung "${roomName}"`);
  await this.quickJoinBot(botId, roomName);
});

Given('Bot {int} joint der Sitzung {string}', async function(botId, roomName) {
  await waitForUserInput(`Bot ${botId} joint der Sitzung "${roomName}"`);
  await this.quickJoinBot(botId, roomName);
});

// When Steps - Audio Aktionen
When('Bot {int} Audio abspielt', async function(botId) {
  await waitForUserInput(`Bot ${botId} spielt Audio ab`);
  await this.startAudioForBot(botId);
});

When('Bots {string} Audio abspielen', async function(botsString) {
  await waitForUserInput(`Bots ${botsString} spielen Audio ab`);
  const botIds = parseBotsString(botsString);
  await this.startAudioForBots(botIds);
});

When('Bot {int} schaltet sich stumm', async function(botId) {
  await waitForUserInput(`Bot ${botId} schaltet sich stumm`);
  await this.muteBot(botId);
});

When('Bot {int} hebt die Stummschaltung auf', async function(botId) {
  await waitForUserInput(`Bot ${botId} hebt die Stummschaltung auf`);
  await this.unmuteBot(botId);
});

When('Bot {int} Taste M betätigt', async function(botId) {
  await waitForUserInput(`Bot ${botId} betätigt Taste M`);
  await this.pressMKey(botId);
});

When('warte {int} Sekunden', async function(seconds) {
  await waitForUserInput(`Warte ${seconds} Sekunden`);
  await this.wait(seconds);
});

// Debug Steps
When('Ich den Inspector öffne', async function() {
  await waitForUserInput('Setze Debug-Breakpoint');
  await this.setDebugBreakpoint('Inspector-Schritt erreicht');
});

When('zeige aktive Bots an', async function() {
  await waitForUserInput('Zeige aktive Bots an');
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

When('ich den Text {string} mit Timestamp logge', async function(text) {
  const timestamp = new Date().toLocaleString('de-DE', { hour12: false });
  console.log(`[${timestamp}] ${text}`);
});

When('I pause', async function() {
  console.log('######################## Pause ########################');
}); 