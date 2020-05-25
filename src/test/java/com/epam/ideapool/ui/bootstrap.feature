Feature: Bootstrap test cases

  Background:
    * configure driver = { type: 'chrome' }
    * def isInViewport =
      """
      function isElementInViewport (el) {

    // Special bonus for those using jQuery
    if (typeof jQuery === "function" && el instanceof jQuery) {
        el = el[0];
    }

    var rect = el.getBoundingClientRect();

    return (
        rect.top >= 0 &&
        rect.left >= 0 &&
        rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) && /* or $(window).height() */
        rect.right <= (window.innerWidth || document.documentElement.clientWidth) /* or $(window).width() */
    );
}
      """
  # * configure driverTarget = { docker: 'justinribeiro/chrome-headless', showDriverLog: true }
  # * configure driverTarget = { docker: 'ptrthomas/karate-chrome', showDriverLog: true }
  # * configure driver = { type: 'chromedriver', showDriverLog: true }
  # * configure driver = { type: 'geckodriver', showDriverLog: true }
  # * configure driver = { type: 'safaridriver', showDriverLog: true }
  # * configure driver = { type: 'iedriver', showDriverLog: true, httpConfig: { readTimeout: 120000 } }

  Scenario: Checking form elements
    Given driver 'https://getbootstrap.com/docs/4.4/components/forms/'
    Then match driver.title == 'Forms · Bootstrap'
    And assert isInViewport waitFor('input[readonly].form-control') == false



  Scenario: Checking landing pages elements
    Given driver 'https://angular.io'
    Then assert locate('.nav-link.home').exists
    And assert waitFor('.hero-logo').exists
    And match text('.hero-headline') == 'One framework.Mobile & desktop.'
    And assert waitFor('.button.hero-cta').exists
    When click('.button.hero-cta')
    Then match driver.url == 'https://angular.io/docs'
    And match text('#introduction-to-the-angular-docs') contains 'Introduction to the Angular Docs'

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