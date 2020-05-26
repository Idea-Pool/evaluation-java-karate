Feature: Bootstrap test cases

  Background:
    * configure driver = { type: 'chrome' }

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
    Then waitForText('main > div:nth-child(43) button.btn.btn-lg.btn-primary', 'Primary button')
    And waitUntil('main > div:nth-child(43) > button.btn.btn-lg.btn-primary', '_.disabled')
    When script('window.scroll(0, window.innerHeight)')
    Then waitForEnabled('main > div:nth-child(38) a.btn.btn-primary.btn-lg.active')

  Scenario: Checking select form elements
    Given driver 'https://getbootstrap.com/docs/4.4/components/forms/#form-controls'
    Then exists('#exampleFormControlSelect1')
    And waitUntil('#exampleFormControlSelect2', '_.multiple')
    And match value('#exampleFormControlSelect1') == '1'
    And def options = scriptAll('#exampleFormControlSelect1 option', '_.innerHTML')
    And match options !contains 'hello'
    And match options contains '2'
    And select('#exampleFormControlSelect1', '2')
    Then match value('#exampleFormControlSelect1') == '2'
    And waitForResultCount('#exampleFormControlSelect1 option', 5)