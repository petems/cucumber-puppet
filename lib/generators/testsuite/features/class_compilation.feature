Feature: class compilation

  Scenario: compile a single class
    Given a node of class "simple"
    When I compile its catalog
    Then compilation should succeed
    Then there should be a resource "File[foo]"

  Scenario: compile multiple classes
    Given a node of class "multi::one"
    And of class "multi::two"
    When I compile its catalog
    Then compilation should succeed
    Then there should be a resource "File[one]"
    And there should be a resource "File[two]"

  Scenario: compile a single class with parameters
    Given a node of class "parameterized::one" with parameters:
      | name     | value |
      | filename | foo   |
    When I compile its catalog
    Then compilation should succeed
    Then there should be a resource "File[foo]"

  Scenario: compile multiple classes with parameters
    Given a node of class "parameterized::one" with parameters:
      | name     | value |
      | filename | foo   |
    And of class "parameterized::two" with parameters:
      | name     | value |
      | filename | bar   |
    When I compile its catalog
    Then compilation should succeed
    Then there should be a resource "File[foo]"
    And there should be a resource "File[bar]"

  Scenario: catch compilation error with a single class
    Given a node of class "nonexistent"
    When I try to compile its catalog
    Then compilation should fail

  Scenario: catch compilation error with a yaml node definition
    Given a node specified by "features/yaml/testnode.com.yaml"
    When I try to compile its catalog
    Then compilation should fail
