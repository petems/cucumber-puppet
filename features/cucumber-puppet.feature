Feature: cucumber-puppet command line options
  In order to influence cucumber-puppet's behaviour
  As a user of cucumber-puppet
  I want it to support certain command line options

  Background:
    Given an uninitialized directory tree

  Scenario: without options
    When I run cucumber-puppet with option ""
    Then it should show usage information

  Scenario: with invalid option
    When I run cucumber-puppet with option "--invalid"
    Then it should show usage information

  Scenario: with non-existent feature
    When I run cucumber-puppet with option "invalid"
    Then it should show "No such file or directory:"

  Scenario: --backtrace

  Scenario: --exclude PATTERN

  Scenario: --expand

  Scenario: --format FORMAT

  Scenario: --help
    When I run cucumber-puppet with option "--help"
    Then it should show usage information

  Scenario: --name NAME

  Scenario: --out FILE|DIR

  Scenario: --tags TAG_EXPRESSION

  Scenario: --verbose

  Scenario: --version
    When I run cucumber-puppet with option "--version"
    Then it should show a version number
