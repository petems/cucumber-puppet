Then /^the "([^\"]*)" package should be installed$/ do  |package|
  steps %Q{
    Then there should be a resource "Package[#{package}]"
    And the state should be "installed"
  }
end
