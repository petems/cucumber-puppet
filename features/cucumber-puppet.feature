Feature: cucumber-puppet command line options
  In order to influence cucumber-puppet's behavior
  As a user of cucumber-puppet
  I want it to support certain command line options

  Background:
    Given an uninitialized directory tree

  Scenario: without any option or feature
    When I run cucumber-puppet with option ""
    Then it should show usage information

  Scenario: with non-existent feature
    When I run cucumber-puppet with option "invalid"
    Then it should show "No such file or directory"

  Scenario Outline: flags, that should be there
    When I run cucumber-puppet with option "--help"
    Then it should show "<option>"

    Examples:
      | option |
      | --backtrace |
      | --help |
      | --version |

  Scenario Outline: disable testcase
    When I generate "world"
    And I generate "testcase"
    And I run cucumber-puppet with option "<option> features"
    Then it should show "0 scenarios"

    Examples:
      | option |
      | --exclude testcase |
      | --name foo |
      | --tags @foo |

  Scenario Outline: enable testcase
    When I generate "world"
    And I generate "testcase"
    And I run cucumber-puppet with option "<option> features"
    Then it should show "1 scenario"

    Examples:
      | option |
      | --exclude foo |
      | --name test |
      | --tags ~@foo |

  Scenario: --format FORMAT
    When I generate "world"
    And I generate "testcase"
    And I run cucumber-puppet with option "--format progress features"
    Then it should show "...."

  Scenario: --help
    When I run cucumber-puppet with option "--help"
    Then it should show usage information

  Scenario: --out FILE|DIR
    When I generate "world"
    And I generate "testcase"
    And I run cucumber-puppet with option "--out foo features"
    Then there should be a file "foo"

  Scenario: --verbose
    When I generate "world"
    And I generate "testcase"
    And I run cucumber-puppet with option "--verbose features"
    Then it should show "Features:"
    And it should show "Code:"

  Scenario: --version
    When I run cucumber-puppet with option "--version"
    Then it should show a version number
