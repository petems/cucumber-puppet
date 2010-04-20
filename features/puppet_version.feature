Feature: Test cucumber-puppet against current Puppet releases
  In order to support a broad user base
  As a developer of cucumber-puppet
  I want cucumber-puppet to properly work with current Puppet releases

  Scenario: Test Puppet 0.24 branch
    Given an initialized directory tree
    When puppet version "0.24.8" is installed
    And I generate "testcase"
    Then cucumber-puppet should successfully run "testcase"
