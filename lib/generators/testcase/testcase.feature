Feature: test case

  Scenario:
    Given a node of class "test"
    When I compile the catalog
    Then there should be a resource "File[foo]"
    And the state should be "present"
