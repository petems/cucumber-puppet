Gem::Specification.new do |s|
  s.version = "0.0.3"

  s.author = "Nikolay Sturm"
  s.description = "cucumber-puppet allows you writing behavioural tests for your puppet manifest"
  s.email = "cucumber-puppet@erisiandiscord.de"
  s.executables = ["cucumber-puppet", "cucumber-puppet-gen"]
  s.files = [
    "bin/cucumber-puppet",
    "bin/cucumber-puppet-gen",
    "lib/cucumber-puppet.rb",
    "lib/cucumber-puppet/puppet.rb",
    "lib/generators/feature/%feature_name%.feature",
    "lib/generators/world/steps/file.rb",
    "lib/generators/world/steps/package.rb",
    "lib/generators/world/steps/puppet.rb",
    "lib/generators/world/steps/service.rb",
    "lib/generators/world/steps/user.rb",
    "lib/generators/world/support/hooks.rb",
    "lib/generators/world/support/world.rb",
    "VERSION.yml",
  ]
  s.homepage = "http://github.com/nistude/cucumber-puppet/"
  s.name = "cucumber-puppet"
  s.summary = "Puppet manifest testing with Cucumber"

  s.add_runtime_dependency(%q<cucumber>, [">= 0.6.4"])
  s.add_runtime_dependency(%q<templater>, [">= 1.0"])
end
