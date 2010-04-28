# cucumber-puppet

`cucumber-puppet` is a tool for behavioral testing of Puppet manifests. It
provides the glue necessary to access Puppet's data structures from Cucumber's
step definitions.

It is currently in alpha testing.

# Requirements

`cucumber-puppet` should work with following program versions. Older versions
might work as well, or not.

- cucumber >= 0.6.4
- gem-man >= 0.2.0 (for reading man pages)
- puppet >= 0.24.8
- ruby >= 1.8.6
- templater >= 1.0.0

For development, these additional programs are needed.

- ronn >= 0.5
- rspec >= 1.3.0

# Quickstart

Install cucumber-puppet

    $ gem install cucumber-puppet

Go to your Puppet directory

    $ cd puppet

Initialise the infrastructure

    $ cucumber-puppet-gen world

Create a feature *bar* for your Puppet module *foo*

    $ cucumber-puppet-gen feature foo bar

Run that feature

    $ cucumber-puppet features/modules/foo/bar.feature

# Usage

## Initial setup

Before writing your first feature, you have to setup the infrastructure in
your Puppet directory. Assuming you develop your Puppet manifests in
*~/puppet/*.

    $ cd ~/puppet
    $ cucumber-puppet-gen world

This installs some example step definitions for cucumber to *./features/steps/*
and ensures the cucumber-puppet glue code is available. You can adapt
cucumber-puppet to your needs in *./features/support/hooks.rb*.

    @confdir    Puppet's confdir
                defaults to /etc/puppet
    @manifest   full path to the manifest to use
                defaults to @confdir + /manifests/site.pp
    facts       this is a hash of facter facts
                defaults to
                    'architecture' => ''
                    'domain' => 'no.domain'
                    'environment' => 'production'
                    'hostname' => 'testnode'
                    'lsbdistcodename' => ''
                    'network_eth0' => '127.0.0.0'
                    'operatingsystem' => ''

## Writing features

cucumber-puppet assumes you have your Puppet manifest organized in modules and
does the same with your feature files. Depending on your current working
directory, `cucumber-puppet-gen` will create new features either in *~puppet/features/modules/foo/* (this is the default) or in *~puppet/modules/foo/features/* (in case your current working directory is somewhere inside *~/puppet/modules/*.

    $ cucumber-puppet-gen feature foo bar

generates *features/modules/foo/bar.feature* from the standard template. Use
this file to write your feature and add missing step definitions to files in
*features/steps/*.

To logically seperate step definitions, the following naming scheme is
suggested

    * *<type>.rb* for type specific steps, for example *user.rb*
    * *module\_<module>.rb* for module specific steps, for example
      *module\_foo.rb*
    * *define\_<define>.rb* for define specific steps, for example
      *define\_bar.rb*

The names don't have any special meaning to cucumber, it finds all *.rb* files,
placed in the proper directory.

## Running features

To run above feature, execute

    $ cucumber-puppet features/modules/foo/bar.feature

and see it complain about missing step definitions. Add these as necessary to
your step files and make your feature green.

For more information about writing cucumber features, see
[cucumber tutorials](http://wiki.github.com/aslakhellesoy/cucumber/tutorials-and-related-blog-posts).

# Acknowledgements

Many thanks to [Bernd Ahlers](http://www.ba-net.org/) for getting me started
with cucumber, rspec and ruby.

cucumber-puppet was inspired by
[Lindsay Holmwood's](http://holmwood.id.au/~lindsay/)
[cucumber-nagios](http://auxesis.github.com/cucumber-nagios/).
