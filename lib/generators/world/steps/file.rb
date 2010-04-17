Then /^the file should be a symlink to "([^\"]*)"$/ do |target|
  fail unless @resource["ensure"] == target
end

Then /^the file should contain "([^\"]*)"$/ do |text|
  fail unless @resource["content"].include?(text)
end

Then /^the (file|script) should have standard permissions$/ do |type|
  if type == "file"
    mode = "0444"
  elsif type == "script"
    mode = "0555"
  end

  steps %Q{
    Then the file should have a "group" of "root"
    And the file should have a "mode" of "#{mode}"
    And the file should have an "owner" of "root"
  }
end

Then /^there should be a (file|script) "([^\"]*)"$/ do |type, name|
  steps %Q{
    Then there should be a resource "File[#{name}]"
    And the state should be "present"
    And the #{type} should have standard permissions
  }
end
