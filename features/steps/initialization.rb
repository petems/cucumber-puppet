Given /^an uninitialized directory tree$/ do
  @dir = Dir.mktmpdir
  @oldwd = Dir.getwd
  fail unless Dir.chdir(@dir)
end

Given /^an initialized directory tree$/ do
  steps %Q{
    Given an uninitialized directory tree
    When I generate "world"
  }
end

Given /^an initialized directory tree for puppet version "([^\"]*)"$/ do |version|
  steps %Q{
    Given an uninitialized directory tree
    When I generate "world" for puppet version "#{version}"
  }
end

When /^I generate "([^\"]*)"$/ do |generator|
  basedir = File.dirname(__FILE__) + "/../.."
  fail unless system("ruby -I#{basedir}/lib #{basedir}/bin/cucumber-puppet-gen #{generator} > /dev/null")
  if generator == "world"
    oldworld = IO.read("features/support/world.rb")
    newworld = []
    newworld << "$LOAD_PATH.unshift '#{basedir}/lib'\n"
    newworld << oldworld
    world = File.open("features/support/world.rb", "w")
    world << newworld
    world.close
  end
end

When /^I generate "([^\"]*)" for puppet version "([^\"]*)"$/ do |generator, version|
  basedir = File.dirname(__FILE__) + "/../.."
  fail unless system("ruby -I#{basedir}/lib #{basedir}/bin/cucumber-puppet-gen #{generator} #{version}")
  if generator == "world"
    oldworld = IO.read("features/support/world.rb")
    newworld = []
    newworld << "$LOAD_PATH.unshift '#{basedir}/lib'\n"
    newworld << oldworld
    world = File.open("features/support/world.rb", "w")
    world << newworld
    world.close
  end
end

Then /^cucumber\-puppet's support infrastructure should be created$/ do
  fail unless File.exists?("features/steps/puppet.rb")
  fail unless File.exists?("features/support/world.rb")
end
