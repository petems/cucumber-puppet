# cucumber-puppet

cucumber-puppet allows you writing behavioural tests for your puppet manifest.
It is currently in alpha testing.

# Quickstart

Install cucumber-puppet

  $ gem install cucumber-puppet

Go to your puppet directory

  $ cd puppet

Initialise cucumber-puppet

  $ cucumber-puppet-gen world

Create a feature "bar" for your puppet module "foo"

  $ cucumber-puppet-gen feature foo bar

Run that feature

  $ cucumber-puppet features/modules/foo/bar.feature

# Installation

# Usage

# Thanks

cucumber-puppet is inspired by
[Lindsay Holmwood's](http://holmwood.id.au/~lindsay/)
[cucumber-nagios](http://auxesis.github.com/cucumber-nagios/).
