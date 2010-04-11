When /^I generate a new feature called "([^\"]*)" for module "([^\"]*)"$/ do |feature, mod|
  fail unless system("cd #{@project} && ./bin/cucumber-puppet-gen feature #{mod} #{feature}")
end
