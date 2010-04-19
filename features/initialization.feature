Feature: Initialization
  In order to start using cucumber-puppet
  As a puppet manifest developer
  I want to initialize my manifest development directory

  Scenario: Generate world
    Given an uninitialized directory tree
    When I generate "world"
    Then cucumber-puppet's support infrastructure should be created
