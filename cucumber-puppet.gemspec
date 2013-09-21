Gem::Specification.new do |s|
  s.version = "0.3.7"

  s.author = "Nikolay Sturm"
  s.description = "cucumber-puppet is a tool for behavioral testing of Puppet catalogs"
  s.email = "cucumber-puppet@erisiandiscord.de"
  s.executables = ["cucumber-puppet", "cucumber-puppet-gen"]
  s.files = [
    "bin/cucumber-puppet",
    "bin/cucumber-puppet-gen",
    "lib/cucumber-puppet.rb",
    "lib/cucumber-puppet/helper.rb",
    "lib/cucumber-puppet/puppet.rb",
    "lib/cucumber-puppet/steps.rb",
    "lib/cucumber-puppet/rake/task.rb",
    "lib/generators/feature/%feature_name%.feature",
    "lib/generators/policy/catalog/policy.feature",
    "man/cucumber-puppet.1",
    "man/cucumber-puppet-gen.1",
    "VERSION.yml",
  ] + Dir.glob("lib/generators/world/**/*.rb")
  s.homepage = "http://projects.puppetlabs.com/projects/cucumber-puppet"
  s.name = "cucumber-puppet"
  s.summary = "Puppet catalog testing with Cucumber"

  s.add_runtime_dependency "cucumber", "1.0.2"
  s.add_runtime_dependency "gem-man", "0.3.0"
  s.add_runtime_dependency "templater", "1.0.0"

  s.add_development_dependency "facter", "1.5.9"
  s.add_development_dependency "puppet", "2.7.3"
  s.add_development_dependency "ronn", "0.7.3"
  s.add_development_dependency "rspec", "2.6.0"
  s.add_development_dependency "rake", "10.1.0"
end
