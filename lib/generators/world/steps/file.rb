Then /^following directories should be created:$/ do |directories|
  directories.hashes.each do |dir|
    steps %Q{
      Then there should be a resource "File[#{dir['name']}]"
      And the state should be "directory"
      And the directory should have standard permissions
    }
  end
end

Then /^the file should be a symlink to "([^\"]*)"$/ do |target|
  fail unless @resource["ensure"] == target
end

Then /^the file should contain "([^\"]*)"$/ do |text|
  fail unless @resource["content"].include?(text)
end

Then /^the (directory|file|script) should have standard permissions$/ do |type|
  case type
  when "directory"
    mode = "0755"
  when "file"
    mode = "0444"
  when "script"
    mode = "0555"
  else
    fail
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
