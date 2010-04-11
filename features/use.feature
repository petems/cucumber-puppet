Feature: Using cucumber-puppet
  In order to test puppet manifests
  As a user of cucumber-puppet
  I want to create and use features

  Background:
    Given cucumber-puppet is installed
    And I create a new project called "puppet"
    And I freeze in dependencies
    When I generate a new feature called "foo" for module "bar"

  Scenario: Create a new feature
    Then a feature file for "foo" in module "bar" should exist

  Scenario: Run a successful feature
    Then the "foo" feature for module "bar" should exit cleanly
