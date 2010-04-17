Then /^service "([^\"]*)" should be "([^\"]*)"$/ do |name, state|
  steps %Q{
    Then there should be a resource "Service[#{name}]"
  }
  if state == "disabled"
    steps %Q{
      Then the service should have "enable" set to "false"
    }
  elsif state == "running"
    steps %Q{
      Then the state should be "#{state}"
    }
  end
end
