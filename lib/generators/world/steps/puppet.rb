Given /^a node of class "([^\"]*)"$/ do |klass|
  @klass = @klass ? @klass.merge({klass => nil}) : {klass => nil}
end

Given /^a node of class "([^\"]*)" with parameters:$/ do |klass, params|
  parameters = {}
  params.hashes.each do |param|
    if param['value'] == "true"
      parameters[param['name']] = true
    elsif param['value'] == "false"
      parameters[param['name']] = false
    else
      parameters[param['name']] = param['value']
    end
  end
  @klass = @klass ? @klass.merge({klass => parameters}) : {klass => parameters}
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
  @compile_error = false
  begin
    compile_catalog
  rescue
    @compile_error = true
  end
end

Then /^compilation should fail$/ do
  fail "Compilation was expected to fail but did not." unless @compile_error == true
end

Then /^the [a-z]* should have "([^\"]*)" set to "(false|true)"$/ do |res, bool|
  if bool == "false"
    fail unless @resource[res] == false
  else
    fail unless @resource[res] == true
  end
end

Then /^the [a-z]* should have an? "([^\"]*)" of "([^\"]*)"$/ do |property, value|
  value.gsub!('\n', "\n") # otherwise newlines don't get handled properly
  if @resource[property].is_a?(Puppet::Resource)
    prop = @resource[property].to_s
  elsif @resource[property].kind_of?(Array)
    if value =~ /, /
      value = value.split(", ")
    elsif value =~ /,/
      value = value.split(",")
    else
      value = value.split
    end

    prop = @resource[property]
  elsif @resource[property].is_a?(String)
    prop = @resource[property]
  else
    fail "Class #{@resource[property].class} not supported. Please modify steps to accomodate."
  end

  fail "Resource #{@resource} had #{property}='#{@resource[property] ? @resource[property] : "<empty>"}', not '#{value}'" \
    unless prop == value
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
