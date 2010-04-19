Feature: Passing options to cucumber
  In order to use cucumber options
  As a puppet manifest developer
  I want to pass options to cucumber

  Scenario: Pass simple options
    Given an uninitialized directory tree
    When I call cucumber-puppet with option "--help"
    Then I should see cucumber's help text

    #  Scenario: Pass options with arguments

    #  Scenario: Pass options with arguments and feature files
