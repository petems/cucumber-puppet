When /^I call cucumber\-puppet with option "([^\"]*)"$/ do |option|
  @cucumber_out = `cucumber-puppet #{option}`
  if $?.to_i > 0
    puts @cucumber_out
    fail
  end
end

Then /^I should see cucumber's help text$/ do
  fail unless @cucumber_out.include?("Usage: cucumber ")
  fail unless @cucumber_out.include?("You're looking at it")
end
