Given /^cucumber\-puppet is installed$/ do
  steps %Q{
    When I build the gem
    And I install the latest gem
    Then I should have cucumber-puppet-gen in my PATH
  }
end
