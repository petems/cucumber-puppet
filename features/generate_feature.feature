Feature: Feature generation
  In order to write features for my puppet manifest
  As a puppet manifest developer
  I want to create new features according to template

  Scenario: Create feature from template
    Given an uninitialized directory tree
    When I generate "feature foo bar"
    Then feature "bar" should exist in "features/modules/foo"
    And it should contain "Feature: bar"
