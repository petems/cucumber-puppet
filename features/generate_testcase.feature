Feature: Generate a test case
  In order to test cucumber-puppet
  As a cucumber-puppet developer
  I want to create a test case for cucumber-puppet

  Scenario:
    Given an initialized directory tree
    When I generate "testcase"
    Then a testcase should have been set up
