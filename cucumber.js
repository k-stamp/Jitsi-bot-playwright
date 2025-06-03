module.exports = {
  default: {
    // Feature-Dateien
    paths: ['features/*.feature'],
    
    // Step-Definitionen
    require: ['features/step_definitions/*.js'],
    
    // Format der Ausgabe
    format: [
      'progress-bar',
      'json:reports/cucumber_report.json',
      'html:reports/cucumber_report.html'
    ],
    
    // Parallele Ausführung
    parallel: 1,
    
    // Timeout für Steps (in Millisekunden)
    timeout: 60000,
    
    // Retry bei Fehlern
    retry: 0,
    
    // Tags
    tags: 'not @skip',
    
    // Sprache
    language: 'de'
  },
  
  debug: {
    paths: ['features/*.feature'],
    require: ['features/step_definitions/*.js'],
    format: ['progress-bar'],
    parallel: 1,
    timeout: 300000, // 5 Minuten für Debugging
    retry: 0,
    tags: '@debug',
    language: 'de'
  }
}; 