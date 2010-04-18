Then /^cron job "([^\"]*)" should be "([^\"]*)"$/ do  |name, state|
  steps %Q{
    Then there should be a resource "Cron[#{name}]"
    And the state should be "#{state}"
  }
end
