Given /^a node of class "([^\"]*)"$/ do |klass|
  @klass = klass
end

Given /^a node with name "([^\"]*)"$/ do |name|
  @hostname = name
end

Given /^a node in network "([^\"]*)"$/ do |network|
  @network_eth0 = network
end

When /^I compile the catalog$/ do
  compile_catalog
end

Then /^the [a-z]* should have "([^\"]*)" set$/ do |res|
  fail unless @resource[res] == true
end

Then /^the [a-z]* should have an? "([^\"]*)" of "([^\"]*)"$/ do |res, value|
  fail unless @resource[res] == value
end

Then /^the [a-z]* should notify "([^\"]*)"$/ do |res|
  fail unless @resource["notify"].to_s == res
end

Then /^the [a-z]* should require "([^\"]*)"$/ do |res|
  req = @resource["require"]
  if req.is_a?(Array)
    found = false
    req.each do |r|
      if r.to_s == res
        found = true
        break
      end
    end
    fail unless found
  else
    fail unless req.to_s == res
  end
end

Then /^the state should be "([^\"]*)"$/ do |state|
  fail unless @resource["ensure"] == state
end

Then /^there should be a resource "([^\"]*)"$/ do |res|
  @resource = resource(res)
  fail unless @resource
end
