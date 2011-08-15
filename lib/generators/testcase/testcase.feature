Feature: test case

  Scenario: test
    Given a node of class "test"
    When I compile the catalog
    Then all resource dependencies should resolve
    Then there should be a resource "File[foo]"
    And the state should be "present"
