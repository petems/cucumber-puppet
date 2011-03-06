Given /^a node of class "([^\"]*)"$/ do |klass|
  @klass = klass
end

Given /^a node of class "([^\"]*)" with parameters:$/ do |klass, params|
  parameters = {}
  params.hashes.each do |param|
    parameters[param['name']] = param['value']
  end
  @klass = { klass => parameters }
end

Given /^a node named "([^\"]*)"$/ do |name|
  @facts['hostname'] = name
end

Given /^a node in network "([^\"]*)"$/ do |network|
  @facts['network_eth0'] = network
end

Given /^it is a virtual node$/ do
  @facts['processor0'] = "QEMU Virtual CPU version 0.11.0"
end

When /^I compile the catalog$/ do
  compile_catalog
end

Then /^the [a-z]* should have "([^\"]*)" set to "(false|true)"$/ do |res, bool|
  if bool == "false"
    fail unless @resource[res] == false
  else
    fail unless @resource[res] == true
  end
end

Then /^the [a-z]* should have an? "([^\"]*)" of "([^\"]*)"$/ do |property, value|
  fail unless @resource[property] == value
end

Then /^the [a-z]* should notify "([^\"]*)"$/ do |res|
  fail unless @resource["notify"].to_s == res
  steps %Q{
    Then the catalog should contain "#{res}"
  }
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
  steps %Q{
    Then the catalog should contain "#{res}"
  }
end

Then /^the catalog should contain "([^\"]*)"$/ do |res|
  fail unless resource(res)
end

Then /^the state should be "([^\"]*)"$/ do |state|
  fail unless @resource["ensure"] == state
end

Then /^there should be a resource "([^\"]*)"$/ do |res|
  @resource = resource(res)
  fail unless @resource
end
