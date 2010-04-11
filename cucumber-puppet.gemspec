Gem::Specification.new do |s|
  s.name = "cucumber-puppet"
  s.version = "0.0"

  s.author = "Nikolay Sturm"
  s.description = "cucumber-puppet allows you writing behavioural tests for your puppet manifest"
  s.email = "sturm@nistu.de"
  s.executables = ["cucumber-puppet-gen"]
  s.files = ["bin/cucumber-puppet-gen", "lib/cucumber-puppet.rb",
    "lib/generators/project/.gitignore", "lib/generators/project/Gemfile",
    "lib/generators/project/bin/cucumber-puppet",
    "lib/generators/project/bin/cucumber-puppet-gen",
    "lib/generators/project/features/steps/file.rb",
    "lib/generators/project/features/steps/package.rb",
    "lib/generators/project/features/steps/puppet.rb",
    "lib/generators/project/features/steps/user.rb",
    "lib/generators/project/features/support/hooks.rb",
    "lib/generators/project/features/support/world.rb",
    "lib/generators/project/lib/generators/feature/%feature_name%.feature",
  ]
  s.homepage = "http://nistude.github.com/cucumber-puppet/"
  s.rubyforge_project = "cucumber-puppet"
  s.summary = "manifest testing for Puppet using Cucumber"

  s.add_runtime_dependency(%q<bundler08>, ["= 0.8.5"])
  s.add_runtime_dependency(%q<rake>, [">= 0.8.3"])
  s.add_runtime_dependency(%q<templater>, [">= 1.0"])
end
