# cucumber-puppet

[![Build Status](https://travis-ci.org/petems/cucumber-puppet.png?branch=master)](https://travis-ci.org/petems/cucumber-puppet)

*The project was discontinued. I'm seeing if I can resurect it*

*Currently cucumber-puppet doesnt support Ruby 1.9+ or any puppetversion beyond 2.7...*

Cucumber-puppet is a tool for specifying Puppet catalog behavior. It uses
Cucumber features as specifications and provides the necessary glue to access a
node's catalog from Cucumber's step definitions.

# Quickstart

Install cucumber-puppet

    $ gem install cucumber-puppet

Go to your Puppet directory

    $ cd puppet

Initialise the infrastructure

    $ cucumber-puppet-gen world

Create a default policy and adapt it to your needs

    $ cucumber-puppet-gen policy
    $ vim features/catalog/policy.feature

Copy YAML node files into place

    $ mkdir features/yaml
    $ cp /var/lib/puppet/yaml/node/localhost.example.com.yaml features/yaml

Apply your policy

    $ cucumber-puppet features/catalog/policy.feature

An example use case can be found at
https://github.com/nistude/cucumber-puppet.example.

Further documentation is available in the
[wiki](http://projects.puppetlabs.com/projects/cucumber-puppet/wiki/).

# Acknowledgements

Many thanks to [Bernd Ahlers](http://www.ba-net.org/) for getting me started
with cucumber, rspec and ruby.

cucumber-puppet was inspired by
[Lindsay Holmwood's](http://holmwood.id.au/~lindsay/)
[cucumber-nagios](http://auxesis.github.com/cucumber-nagios/).
