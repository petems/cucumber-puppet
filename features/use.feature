Feature: Using cucumber-puppet
  In order to test puppet manifests
  A cucumber feature
  Must be created

  Scenario: Create a new feature
    Given cucumber-puppet is installed
    And I create a new project called "puppet"
    And I freeze in dependencies
    When I generate a new feature called "setup" for module "pxe"
    Then a feature file for "setup" in module "pxe" should exist
