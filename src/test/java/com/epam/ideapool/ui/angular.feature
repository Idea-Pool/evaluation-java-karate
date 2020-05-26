Feature: Angular test cases

  Background:
    * configure driver = { type: 'chrome', showDriverLog: true }

  Scenario: Checking landing pages elements
    Given driver 'https://angular.io'
    Then assert locate('.nav-link.home').exists
    And assert waitFor('.hero-logo').exists
    And match text('.hero-headline') == 'One framework.Mobile & desktop.'
    And assert waitFor('.button.hero-cta').exists
    When click('.button.hero-cta')
    Then match driver.url == 'https://angular.io/docs'
    And waitForText('#introduction-to-the-angular-docs', 'Introduction to the Angular Docs')

  Scenario: Checking search field on landing page
    Given driver 'https://angular.io'
    Then waitFor('.search-container > input')
    And match value('.search-container > input') == ''
    And match attribute('.search-container > input', 'placeholder') == 'Search'
    When click('.search-container > input')
    And input('.search-container > input', 'directive')
    And waitForText('div.search-area.ng-star-inserted h3', 'api')
    And assert waitFor("//h3[contains(@class, 'search-section-header') and contains(text(), 'api')]/..//span[text() = 'Directive']").exists
    When click("//a[contains(@href, 'Directive')]")
    Then match driver.url == 'https://angular.io/api/core/Directive'
    And waitForText('#directive', 'Directive')