Gem::Specification.new do |s|
  s.version = "0.0.5"

  s.author = "Nikolay Sturm"
  s.description = "cucumber-puppet is a tool for behavioral testing of Puppet manifests"
  s.email = "cucumber-puppet@erisiandiscord.de"
  s.executables = ["cucumber-puppet", "cucumber-puppet-gen"]
  s.files = [
    "bin/cucumber-puppet",
    "bin/cucumber-puppet-gen",
    "lib/cucumber-puppet.rb",
    "lib/cucumber-puppet/helper.rb",
    "lib/cucumber-puppet/puppet.rb",
    "lib/cucumber-puppet/rake/task.rb",
    "lib/generators/feature/%feature_name%.feature",
    "man/cucumber-puppet.1",
    "man/cucumber-puppet-gen.1",
    "VERSION.yml",
  ] + Dir.glob("lib/generators/world/**/*.rb")
  s.homepage = "http://github.com/nistude/cucumber-puppet/"
  s.name = "cucumber-puppet"
  s.summary = "Puppet manifest testing with Cucumber"

  s.add_runtime_dependency(%q<cucumber>, [">= 0.6.4"])
  s.add_runtime_dependency(%q<gem-man>, [">= 0.2.0"])
  s.add_runtime_dependency(%q<templater>, [">= 1.0"])
end
