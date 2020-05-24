Feature: Angulartest

  Background:
    * configure driver = { type: 'chrome', showDriverLog: true }
  # * configure driverTarget = { docker: 'justinribeiro/chrome-headless', showDriverLog: true }
  # * configure driverTarget = { docker: 'ptrthomas/karate-chrome', showDriverLog: true }
  # * configure driver = { type: 'chromedriver', showDriverLog: true }
  # * configure driver = { type: 'geckodriver', showDriverLog: true }
  # * configure driver = { type: 'safaridriver', showDriverLog: true }
  # * configure driver = { type: 'iedriver', showDriverLog: true, httpConfig: { readTimeout: 120000 } }

  Scenario: Angular Home Page
    Given driver 'https://angular.io'
    Then assert locate('.nav-link.home').exists
    And assert waitFor('.hero-logo').exists
    And match text('.hero-headline') == 'One framework.Mobile & desktop.'
    And assert locate('.button.hero-cta').exists
    When click('.button.hero-cta')
    Then match driver.url == 'https://angular.io/docs'
    And match text('#introduction-to-the-angular-docs') contains 'Introduction to the Angular Docs'