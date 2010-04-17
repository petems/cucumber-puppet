# cucumber-puppet

cucumber-puppet allows you writing behavioural tests for your Puppet manifest.
It is currently in alpha testing.

# Quickstart

Install cucumber-puppet

    $ gem install cucumber-puppet

Go to your puppet directory

    $ cd puppet

Initialise cucumber-puppet

    $ cucumber-puppet-gen world

Create a feature *bar* for your puppet module *foo*

    $ cucumber-puppet-gen feature foo bar

Run that feature

    $ cucumber-puppet features/modules/foo/bar.feature

# Installation

Until its first release, you have to build the gem yourself. Prerequisites
for this step are *gem* and *rake* (not strictly, but it makes life easier).

You start by first cloning the repository

    $ gem clone http://github.com/nistude/cucumber-puppet.git

and building the gem.

    $ cd cucumber-puppet
    $ rake build

Then you can install it to your home directory, or system wide if you execute
the next step as root.

    $ rake install

# Usage

## Initial setup

Before writing your first feature, you have to setup some infrastructure in
your puppet directory. Assuming you develop your puppet manifest in *~/puppet/*.

    $ cd ~/puppet
    $ cucumber-puppet-gen world

This installs some example step definitions for cucumber to *features/steps/*
and ensures the cucumber-puppet glue code is available. You can adapt
cucumber-puppet to your needs in *features/support/hooks.rb*.

    @confdir	puppet's confdir
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

## Writing Features

cucumber-puppet assumes you have your puppet manifest organized in modules and
does the same with your feature files.

    $ cucumber-puppet-gen feature foo bar

generates *features/modules/foo/bar.feature* from the standard template. Use
this file to write your feature and add missing step definitions to files in
*features/steps/*.

# Acknowledgements

cucumber-puppet was inspired by
[Lindsay Holmwood's](http://holmwood.id.au/~lindsay/)
[cucumber-nagios](http://auxesis.github.com/cucumber-nagios/).
