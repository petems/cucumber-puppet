Given /^an uninitialized directory tree$/ do
  @dir = Dir.mktmpdir
  @oldwd = Dir.getwd
  Dir.chdir(@dir)
end

When /^I generate "([^\"]*)"$/ do |generator|
  system("cucumber-puppet-gen #{generator} > /dev/null")
end

Then /^cucumber\-puppet's support infrastructure should be created$/ do
  fail unless File.exists?("features/steps/puppet.rb")
  fail unless File.exists?("features/support/world.rb")
end
