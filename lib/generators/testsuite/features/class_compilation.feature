Feature: class compilation

  Scenario: compile a simple class
    Given a node of class "simple"
    When I compile the catalog
    Then compilation should succeed
    Then all resource dependencies should resolve
    Then there should be a resource "File[foo]"

  Scenario: multiple classes
    Given a node of class "multi::one"
    And of class "multi::two"
    When I compile the catalog
    Then compilation should succeed
    Then all resource dependencies should resolve
    Then there should be a resource "File[one]"
    And there should be a resource "File[two]"
