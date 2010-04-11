When /^I generate a new feature called "([^\"]*)" for module "([^\"]*)"$/ do |feature, mod|
  fail unless system("cd #{@project} && ./bin/cucumber-puppet-gen feature #{mod} #{feature}")
end

Then /^a feature file for "([^\"]*)" in module "([^\"]*)" should exist$/ do |feature, mod|
  fail unless File.exists?("#{@project}/features/modules/#{mod}/#{feature}.feature")
end
