Feature: Policy generation
  In order to write a catalog policy
  As a puppet manifest developer
  I want to create a default policy

  Scenario: Create default policy
    Given an uninitialized directory tree
    When I generate "policy"
    Then feature "policy" should exist in "features/catalog"
