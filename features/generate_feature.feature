Feature: Feature generation
  In order to write features for my puppet manifest
  As a puppet manifest developer
  I want to create new features according to template

  Scenario: Create feature in base directory
    Given an uninitialized directory tree
    When I generate "feature foo bar"
    Then feature "bar" should exist in "features/modules/foo"
    And it should contain "Feature: bar"

  Scenario: Create feature in modules directory (modules/)
    Given a working directory of "modules"
    When I generate "feature foo bar"
    Then feature "bar" should exist in "foo/features"

  Scenario: Create feature in a module's directory
    Given a working directory of "modules/foo"
    When I generate "feature foo bar"
    Then feature "bar" should exist in "features"

  Scenario: Create feature in a module's features directory
    Given a working directory of "modules/foo/features"
    When I generate "feature foo bar"
    Then feature "bar" should exist in "."
