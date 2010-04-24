Feature: Run testcase from different locations
  In order to support running cucumber-puppet from different locations
  As a cucumber-puppet user
  I want it to find all necessary step definitions

  Scenario Outline: Run testcase from different directories
    Given an initialized directory tree
    And a working directory of "<cwd>"
    When I generate "testcase"
    Then cucumber-puppet should successfully run "<feature>"

    Examples:
      | cwd | feature |
      | . | features/modules/testcase/testcase.feature |
      | features | modules/testcase/testcase.feature |
      | features/modules | testcase/testcase.feature |
      | features/modules/testcase | testcase.feature |
      | modules | testcase/features/testcase.feature |
      | modules/testcase | features/testcase.feature |
      | modules/testcase/features | testcase.feature |

  Scenario: Run testcase with custom steps from modules dir
    Given an uninitialized directory tree
    And a working directory of "modules/testcase"
    When I generate "world"
    And I generate "testcase"
    Then cucumber-puppet should successfully run "features/testcase.feature"
