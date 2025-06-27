module.exports = {
  default: {
    require: [
      'features/step_definitions/**/*.js',
      'features/support/**/*.js'
    ],
    format: [
      'progress-bar',
      'json:reports/cucumber_report.json'
    ],
    formatOptions: {
      snippetInterface: 'async-await'
    },
    paths: ['features/**/*.feature'],
    dryRun: false,
    failFast: false,
    strict: true,
    retry: 0
  }
}; 