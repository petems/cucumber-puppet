When /^I run cucumber\-puppet with option "([^\"]*)"$/ do |option|
  basedir = File.dirname(__FILE__) + "/../.."
  @output = `ruby -I#{basedir}/lib #{basedir}/bin/cucumber-puppet #{option} 2>&1`
end

Then /^it should show a version number$/ do
  fail unless @output.match(/\d\.\d\.\d/)
end

Then /^it should show "([^\"]*)"$/ do |text|
  fail unless @output.include?(text)
end

Then /^it should show usage information$/ do
  fail unless @output.include?("Usage: cucumber-puppet")
end
