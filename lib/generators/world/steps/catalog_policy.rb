Given /^a node specified by "([^\"]*)"$/ do |file|
  # file: yaml node file, usually from /var/lib/puppet/yaml/node
  fail("Cannot find node facts #{file}.") unless File.exist?(file)
  @node = YAML.load_file(file)
  file("Invalid node file #{file}, this should come from " +
    "/var/lib/puppet/yaml/node.") unless @node.is_a?(Puppet::Node)
end

When /^I compile its catalog$/ do
  compile_catalog(@node)
end

Then /^all "([^\"]*)" should resolve$/ do |parameter|
  # paramter: before, notify, require, or subscribe
  @catalog.resources.each do |name|
    resource = get_resource(name)

    dependency = resource[parameter]
    next unless dependency
    if dependency.is_a?(Array)
      dependency.each do |dep|
        fail("#{resource} cannot #{parameter} #{dep}, not in catalog.") \
          unless get_resource(dep.to_s)
      end
    elsif dependency.is_a?(Puppet::Resource::Reference)
      fail("#{resource} cannot #{parameter} #{dependency}, not in catalog.") \
        unless get_resource(dependency.to_s)
    else
      fail("#{resource} #{parameter} #{dependency} of unknown class.")
    end
  end
end

Then /^all file sources should exist in git repository$/ do
  @catalog.resources.each do |name|
    next unless name.match(/^File/)
    file = get_resource(name)

    next unless file['source']
    source = file['source']

    filepath = source.gsub(%r{^puppet:///([^/]*)/(.*)$}, 'modules/\1/files/\2')
    fail("#{name}: source #{filepath} not in git repository.") unless
      system("git cat-file -e :#{filepath} > /dev/null 2>&1")
  end
end

Then /^all file templates should exist in git repository$/ do
  Dir.glob('modules/*/templates/**.erb').each do |template|
    fail("#{template} not in git.") unless
      system("git cat-file -e :#{template} > /dev/null 2>&1")
  end
end

Then /^all resource dependencies should resolve$/ do
  steps %Q{
    Then all "before" should resolve
    And all "notify" should resolve
    And all "require" should resolve
    And all "subscribe" should resolve
  }
end

Then /^compilation should succeed$/ do
  fail("Catalog compilation failed.") unless
    @catalog.is_a?(Puppet::Resource::Catalog)
end
