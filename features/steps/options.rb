When /^I call cucumber\-puppet with option "([^\"]*)"$/ do |option|
  basedir = File.dirname(__FILE__) + "/../.."
  @output = `ruby #{basedir}/bin/cucumber-puppet #{option} 2>&1`
end

When /^I call "([^\"]*)" without option$/ do |program|
  basedir = File.dirname(__FILE__) + "/../.."
  @output = `ruby -I#{basedir}/lib #{basedir}/bin/#{program} 2>&1`
end

When /^I create an empty scenario$/ do
  Dir.mkdir("features")
  f = File.open("features/empty.feature", "w")
  f.puts("Feature: empty", "Scenario: empty")
  f.close
end

Then /^I should see cucumber's help text$/ do
  fail unless @output.include?("Usage: cucumber ")
  fail unless @output.include?("You're looking at it")
end

Then /^I should see "([^\"]*)"$/ do |text|
  fail unless @output.include?(text)
end
