# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.version       = "0.4.0"

  gem.author        = "Nikolay Sturm"
  gem.description   = "cucumber-puppet is a tool for behavioral testing of Puppet catalogs"
  gem.email         = "cucumber-puppet@erisiandiscord.de"
  gem.homepage      = "http://project.puppetlab.com/projects/cucumber-puppet"
  gem.name          = "cucumber-puppet"
  gem.summary       = "Puppet catalog testing with Cucumber"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "cucumber", "1.0.2"
  gem.add_runtime_dependency "gem-man", "0.3.0"
  gem.add_runtime_dependency "templater", "1.0.0"

  gem.add_development_dependency "facter", "1.5.9"
  gem.add_development_dependency "puppet", "2.7.3"
  gem.add_development_dependency "ronn", "0.7.3"
  gem.add_development_dependency "rspec", "2.6.0"
  gem.add_development_dependency "rake", "10.1.0"
end
