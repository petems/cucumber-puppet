Feature: class parameters

  Scenario Outline: boolean parameters
    Given a node of class "parameterized::three" with parameters:
      | name         | value     |
      | include_file | <boolean> |
    When I compile its catalog
    Then compilation should succeed
    Then there should be <include> resource "File[foo]"

    Examples:
      | boolean | include |
      | true    | a       |
      | false   | no      |
