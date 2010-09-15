Feature: General policy for all catalogs
  In order to ensure applicability of a host's catalog
  As a manifest developer
  I want all catalogs to obey some general rules

  Scenario Outline: Compile and verify catalog
    Given a node specified by "features/yaml/<hostname>.example.com.yaml"
    When I compile its catalog
    Then compilation should succeed
    And all resource dependencies should resolve

    Examples:
      | hostname  |
      | localhost |
