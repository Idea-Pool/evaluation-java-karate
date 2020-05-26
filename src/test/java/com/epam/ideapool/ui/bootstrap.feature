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
    And exists('input[readonly].form-control')
    Then scroll('input[readonly].form-control')

  Scenario: Interaction with checkbox form elements
    Given driver 'https://getbootstrap.com/docs/4.4/components/forms/#checkboxes-and-radios'
    Then waitForEnabled('#defaultCheck1')
    And waitUntil('#defaultCheck2', '_.disabled')
    And waitUntil('#defaultCheck1', '!_.checked')
    When click('#defaultCheck1')
    Then waitUntil('#defaultCheck1', '_.checked')

  Scenario: Interaction with radio form elements
    Given driver 'https://getbootstrap.com/docs/4.4/components/forms/#checkboxes-and-radios'
    Then waitForEnabled('#exampleRadios1')
    And waitUntil('#exampleRadios3', '_.disabled')
    And waitUntil('#exampleRadios1', '_.checked')
    And waitUntil('#exampleRadios2', '!_.checked')
    When click('#exampleRadios2')
    Then waitUntil('#exampleRadios1', '!_.checked')
    And waitUntil('#exampleRadios2', '_.checked')

  Scenario: Checking button form elements
    Given driver 'https://getbootstrap.com/docs/4.4/components/buttons/#disabled-state'
    Then match waitFor('main > div:nth-child(43) button.btn.btn-lg.btn-primary').text == 'Primary button'
    And waitUntil('main > div:nth-child(43) > button.btn.btn-lg.btn-primary', '_.disabled')
    When script('window.scroll(0, window.innerHeight)')
    Then waitForEnabled('main > div:nth-child(38) a.btn.btn-primary.btn-lg.active')

### `TC-7` Checking select form elements
#
#  1. **Given** https://getbootstrap.com/docs/4.4/components/forms/#form-controls URL is opened
#  1. **Then** The example select should be visible
#  1. **And** The example multiple select should be a multiple select
#  1. **And** The selected option in example select should be "1"
#  1. **And** there should not be option like "hello" in example select
#  1. **And** there should be option like "2" in example select
#  1. **When** The option "2" is selected in example select
#  1. **Then** The selected option in example select should be "2"
#  1. **And** Thu number of options in example select should be 5