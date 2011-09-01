Given /^a node of class "([^\"]*)"$/ do |klass|
  @klass = klass
end

# And
Given /^of class "([^\"]*)"$/ do |klass|
  # we expect this to only be used in conjunction with other classes
  fail unless @klass

  if @klass.is_a? String
    # FIXME: Arrays currently unsupported
    @klass = {@klass => nil, klass => nil}
  elsif @klass.is_a? Hash
    @klass = @klass.merge({klass => nil})
  end
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
  @klass = { klass => parameters }
end

# And
Given /^of class "([^\"]*)" with parameters:$/ do |klass, params|
  # we expect this to only be used in conjunction with other classes
  fail unless @klass

  parameters = {}
  params.hashes.each do |param|
    parameters[param['name']] = param['value']
  end

  if @klass.is_a? String
    # FIXME: Arrays currently unsupported
    @klass = {@klass => nil, klass => parameters}
  elsif @klass.is_a? Hash
    @klass = @klass.merge({klass => parameters})
  end
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
  steps %Q{ When I compile its catalog }
end

When /^I try to compile the catalog$/ do
  steps %Q{ When I try to compile its catalog }
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

    prop = []
    @resource[property].each do |p|
      prop << p.to_s
    end
  elsif @resource[property].is_a?(String)
    prop = @resource[property]
  else
    fail "Class #{@resource[property].class} not supported. Please modify steps to accomodate."
  end

  fail "Resource #{@resource} had #{property}='#{prop ? prop.to_s : "<empty>"}', not '#{value}'" unless prop == value
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
    fail("#{@resource} should require #{res}") unless found
  else
    fail("#{@resource} should require #{res}") unless req.to_s == res
  end
  steps %Q{
    Then the catalog should contain "#{res}"
  }
end

Then /^the catalog should contain "([^\"]*)"$/ do |res|
  fail("#{res} not in catalog") unless resource(res)
end

Then /^the state should be "([^\"]*)"$/ do |state|
  fail unless @resource["ensure"] == state
end

Then /^there should be a resource "([^\"]*)"$/ do |res|
  @resource = resource(res)
  fail("#{res} not in catalog") unless @resource
end

Then /^there should be no resource "([^\"]*)"$/ do |res|
  @resource = resource(res)
  fail("#{@resource} in catalog although it shouldn't be") if @resource
end
