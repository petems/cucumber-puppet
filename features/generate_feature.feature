Feature: Feature generation
  In order to write features for my puppet manifest
  As a puppet manifest developer
  I want to create new features according to template

  Scenario: Create feature in base directory
    Given an uninitialized directory tree
    When I generate "feature foo bar"
    Then feature "bar" should exist in "features/modules/foo"
    And it should contain "Feature: bar"

  Scenario Outline: Create feature from several different places
    Given a working directory of "<cwd>"
    When I generate "feature foo bar"
    Then feature "bar" should exist in "<destdir>"

    Examples:
      | cwd | destdir |
      | features | modules/foo |
      | features/modules | foo |
      | features/modules/foo | . |
      | modules | foo/features |
      | modules/foo | features |
      | modules/foo/features | . |
      | test | features/modules/foo |
