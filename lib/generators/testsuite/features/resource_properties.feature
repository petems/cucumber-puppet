Feature: resource properties

  Scenario: resolve simple alias
    Given a node of class "aliased"
    When I compile its catalog
    Then all resource dependencies should resolve
    Then there should be a resource "File[foo]"
    And the file should require "File[bar]"

  Scenario: resolve alias array
    Given a node of class "alias_array"
    When I compile its catalog
    Then all resource dependencies should resolve
    Then there should be a resource "File[foo]"
    And the file should require "File[bar]"
    And the file should require "File[baz]"

  Scenario: support property arrays
    Given a node of class "alias_array"
    When I compile its catalog
    Then there should be a resource "File[foo]"
    And the file should have a "require" of "File[bar], File[baz]"
