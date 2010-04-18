Then /^exec "([^\"]*)" should be present$/ do |name|
  steps %Q{
    Then there should be a resource "Exec[#{name}]"
  }
end
