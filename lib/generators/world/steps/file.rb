Then /^the file should be a symlink to "([^\"]*)"$/ do |target|
  fail unless @resource["ensure"] == target
end

Then /^the file should contain "([^\"]*)"$/ do |text|
  fail unless @resource["content"].include?(text)
end

Then /^the file should have standard permissions$/ do
  steps %Q{
    Then the file should have a "group" of "root"
    And the file should have a "mode" of "0444"
    And the file should have an "owner" of "root"
  }
end

Then /^there should be a file "([^\"]*)"$/ do |file|
  steps %Q{
    Then there should be a resource "File[#{file}]"
    And the state should be "present"
    And the file should have standard permissions
  }
end
