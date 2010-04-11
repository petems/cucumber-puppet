Feature: Creating a project
  In order to use puppet
  A cucumber-puppet project
  Must be created

  Scenario: Create a new project
    Given cucumber-puppet is installed
    When I create a new project called "puppet"
    And I freeze in dependencies
    Then my gems directory should be populated
