Given /^a node specified by "([^\"]*)"$/ do |file|
  # file: yaml node file
  fail("Cannot find node facts #{file}.") unless File.exist?(file)
  @node = YAML.load_file(file)
  file("Invalid node file #{file}, this should come from " +
    "/var/lib/puppet/yaml/node.") unless @node.is_a?(Puppet::Node)
end

Given /^I use storeconfigs$/ do
  # XXX workaround storeconfig warnings
  Puppet::Util::Log.level = :err
end

When /^I compile its catalog$/ do
  compile_catalog(@node)
end

Then /^all resource dependencies should resolve$/ do
  steps %Q{
    Then all "before" should resolve
    And all "notify" should resolve
    And all "require" should resolve
    And all "subscribe" should resolve
  }
end

Then /^all "(before|notify|require|subscribe)" should resolve$/ do |parameter|
  catalog_resources.each do |resource|
    dependency = [ resource[parameter] ].flatten.compact

    dependency.each do |dep|
      fail("#{resource} cannot #{parameter} #{dep}, not in catalog.") \
        unless resource(dep.to_s)
    end
  end
end

Then /^compilation should succeed$/ do
  fail("Catalog compilation failed.") unless
    @catalog.is_a?(Puppet::Resource::Catalog)
end
