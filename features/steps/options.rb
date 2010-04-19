When /^I call cucumber\-puppet with option "([^\"]*)"$/ do |option|
  basedir = File.dirname(__FILE__) + "/../.."
  @output = `ruby #{basedir}/bin/cucumber-puppet #{option}`
  if $?.to_i > 0
    puts @output
    fail
  end
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
