# cucumber-puppet

cucumber-puppet allows you writing behavioural tests for your Puppet manifest.
It is currently in alpha testing.

# Requirements

cucumber-puppet should work with following program versions. Older versions
might work as well, or not.

- cucumber >= 0.6.4
- puppet >= 0.24.8
- ruby >= 1.8.6
- templater >= 1.0.0

# Quickstart

Install cucumber-puppet

	$ gem install cucumber-puppet

Go to your Puppet directory

	$ cd puppet

Initialise cucumber-puppet

	$ cucumber-puppet-gen world

Create a feature *bar* for your Puppet module *foo*

	$ cucumber-puppet-gen feature foo bar

Run that feature

	$ cucumber-puppet features/modules/foo/bar.feature

# Installation

The easiest way to use cucumber-puppet is to install the gem.

	$ gem install cucumber-puppet

## Manual installation from source

You start by first cloning the repository

	$ git clone http://github.com/nistude/cucumber-puppet.git

and building the gem.

	$ cd cucumber-puppet
	$ rake build

Then you can install it to your home directory, or system wide if you execute
the next step as root.

	$ rake install

# Usage

## Initial setup

Before writing your first feature, you have to setup the infrastructure in
your Puppet directory. Assuming you develop your Puppet manifest in *~/puppet/*.

	$ cd ~/puppet
	$ cucumber-puppet-gen world

This installs some example step definitions for cucumber to *./features/steps/*
and ensures the cucumber-puppet glue code is available. You can adapt
cucumber-puppet to your needs in *./features/support/hooks.rb*.

    @confdir	Puppet's confdir
		defaults to /etc/puppet
    @manifest	full path to the manifest to use
		defaults to @confdir + /manifests/site.pp
    facts	this is a hash for facter facts
		defaults to
			'architecture' => ""
			'domain' => "no.domain"
			'environment' => "production"
			'hostname' => "testnode"
			'lsbdistcodename' => ""
			'network_eth0' => "127.0.0.0"
			'operatingsystem' => ""

## Writing features

cucumber-puppet assumes you have your Puppet manifest organized in modules and
does the same with your feature files.

	$ cucumber-puppet-gen feature foo bar

generates *./features/modules/foo/bar.feature* from the standard template. Use
this file to write your feature and add missing step definitions to files in
*./features/steps/*.

## Running features

To run above feature, execute

	$ cucumber-puppet features/modules/foo/bar.feature

and see it complain about missing step definitions. Add these to *.rb* files in
*./features/steps/*.

For more information about writing cucumber features, see
[cucumber tutorials](http://wiki.github.com/aslakhellesoy/cucumber/tutorials-and-related-blog-posts).

# Acknowledgements

cucumber-puppet was inspired by
[Lindsay Holmwood's](http://holmwood.id.au/~lindsay/)
[cucumber-nagios](http://auxesis.github.com/cucumber-nagios/).
