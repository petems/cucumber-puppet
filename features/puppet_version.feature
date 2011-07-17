Feature: Test cucumber-puppet against various Puppet releases
  In order to support a broad user base
  As a developer of cucumber-puppet
  I want cucumber-puppet to properly work with various Puppet releases

  @puppet_version
  Scenario Outline: Test specific Puppet version
    Given an initialized directory tree for puppet version "<version>"
    When I generate "testcase"
    Then cucumber-puppet should successfully run "features"

    Examples:
      | version |
      | 0.24.8 |
      | 0.24.9 |
      | 0.25.0 |
      | 0.25.1 |
      | 0.25.2 |
      | 0.25.3 |
      | 0.25.4 |
      | 0.25.5 |
      | 2.6.0  |
      | 2.6.1  |
      | 2.6.2  |
      | 2.6.3  |
      | 2.6.4  |
      | 2.6.5  |
      | 2.6.6  |
      | 2.6.7  |
      | 2.6.8  |
      | 2.6.9  |
