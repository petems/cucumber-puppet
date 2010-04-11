Feature: Using cucumber-puppet
  In order to test puppet manifests
  As a user of cucumber-puppet
  I want to create and use features

  Background:
    Given cucumber-puppet is installed
    And I create a new project called "puppet"
    And I freeze in dependencies

  Scenario: Create a new feature
    When I generate a new feature called "foo" for module "bar"
    Then a feature file for "foo" in module "bar" should exist

  Scenario: Run a successful feature
    When I generate an empty feature
    Then the empty feature should exit cleanly
