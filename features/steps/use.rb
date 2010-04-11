When /^I generate a new feature called "([^\"]*)" for module "([^\"]*)"$/ do |feature, mod|
  fail unless system("cd #{@project} && ./bin/cucumber-puppet-gen feature #{mod} #{feature}")
end

When /^I generate an empty feature$/ do
  fail unless system("echo 'Feature: empty\nScenario: empty\n' > #{@project}/features/empty.feature")
end

Then /^a feature file for "([^\"]*)" in module "([^\"]*)" should exist$/ do |feature, mod|
  fail unless File.exists?("#{@project}/features/modules/#{mod}/#{feature}.feature")
end

Then /^the empty feature should exit cleanly$/ do
  fail unless system("cd #{@project} && ./bin/cucumber-puppet features/empty.feature")
end
