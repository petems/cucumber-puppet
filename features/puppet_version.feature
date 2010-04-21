Feature: Test cucumber-puppet against various Puppet releases
  In order to support a broad user base
  As a developer of cucumber-puppet
  I want cucumber-puppet to properly work with various Puppet releases

  @puppet_version
  Scenario Outline: Test specific Puppet version
    Given an initialized directory tree for puppet version "<version>"
    When I generate "testcase"
    Then cucumber-puppet should successfully run "testcase"

    Examples:
      | version |
      | 0.24.8 |
      | 0.24.9 |
