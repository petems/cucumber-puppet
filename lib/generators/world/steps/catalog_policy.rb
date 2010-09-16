Given /^a node specified by "([^\"]*)"$/ do |file|
  # file: yaml node file
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
  catalog_resources.each do |resource|
    dependency = [ resource[parameter] ].flatten.compact

    dependency.each do |dep|
      fail("#{resource} cannot #{parameter} #{dep}, not in catalog.") \
        unless resource(dep.to_s)
    end
  end
end

Then /^all file sources should exist in git repository$/ do
  catalog_resources.each do |resource|
    next unless resource.type == "File"

    source = resource['source']
    next unless source

    filepath = source.gsub(%r{^puppet:///([^/]*)/(.*)$}, 'modules/\1/files/\2')
    fail("#{resource}: source #{filepath} not in git repository.") unless
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
