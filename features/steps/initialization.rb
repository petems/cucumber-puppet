Given /^an uninitialized directory tree$/ do
  @dir = Dir.mktmpdir
  @oldwd = Dir.getwd
  fail unless Dir.chdir(@dir)
end

When /^I generate "([^\"]*)"$/ do |generator|
  basedir = File.dirname(__FILE__) + "/../.."
  fail unless system("ruby -I#{basedir}/lib #{basedir}/bin/cucumber-puppet-gen #{generator} > /dev/null")
  if generator == "world"
    env = File.open("features/support/env.rb", "w")
    env.puts("$LOAD_PATH.unshift \"#{basedir}/lib\"")
  end
end

Then /^cucumber\-puppet's support infrastructure should be created$/ do
  fail unless File.exists?("features/steps/puppet.rb")
  fail unless File.exists?("features/support/world.rb")
end
