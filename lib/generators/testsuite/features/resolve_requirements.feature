Feature: resolve requirements
  In order to require resources by their alias name
  cucumber-puppet must resolve alias names

  Scenario: resolve simple alias
    Given a node of class "aliased"
    When I compile its catalog
    Then compilation should succeed
    Then all resource dependencies should resolve
    Then there should be a resource "File[foo]"
    And the file should require "File[bar]"

  Scenario: resolve alias array
    Given a node of class "alias_array"
    When I compile its catalog
    Then compilation should succeed
    Then all resource dependencies should resolve
    Then there should be a resource "File[foo]"
    And the file should require "File[bar]"
    And the file should require "File[baz]"

