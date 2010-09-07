# cucumber-puppet

Cucumber-puppet is a tool for specifying Puppet catalog behavior by means of a
catalog-wide policy. It uses Cucumber features as specifications and provides
the necessary glue to access a node's catalog from Cucumber's step definitions.

It is currently in alpha testing.

# Requirements

`cucumber-puppet` should work with following program versions. Older versions
might work as well, or not.

- cucumber >= 0.8.5
- gem-man >= 0.2.0 (for reading man pages)
- puppet >= 0.25.5
- ruby >= 1.8.7
- templater >= 1.0.0

For development, these additional programs are needed.

- ronn >= 0.7.3
- rspec >= 1.3.0

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

Further documentation is available in the
[wiki](http://projects.puppetlabs.com/projects/cucumber-puppet/wiki/).

# Acknowledgements

Many thanks to [Bernd Ahlers](http://www.ba-net.org/) for getting me started
with cucumber, rspec and ruby.

cucumber-puppet was inspired by
[Lindsay Holmwood's](http://holmwood.id.au/~lindsay/)
[cucumber-nagios](http://auxesis.github.com/cucumber-nagios/).
