Feature: Passing options to cucumber
  In order to use cucumber options
  As a puppet manifest developer
  I want to pass options to cucumber

  Background:
    Given an uninitialized directory tree
    When I create an empty scenario

  Scenario Outline: Pass nothing
    When I generate "world"
    And I call "<program>" without option
    Then I should see "Usage: <program>"

    Examples:
      | program |
      | cucumber-puppet |
      | cucumber-puppet-gen |

  Scenario: Pass simple options
    When I call cucumber-puppet with option "--help"
    Then I should see cucumber's help text

  Scenario: Pass options with arguments
    When I call cucumber-puppet with option "--name foo"
    Then I should see "0 scenarios"

  Scenario: Pass options with arguments and feature dir
    When I call cucumber-puppet with option "--name empty features"
    Then I should see "1 scenario"

  Scenario: Pass non-existent feature
    When I call cucumber-puppet with option "none"
    Then I should see "No such file or directory - none (Errno::ENOENT)"
