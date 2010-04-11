# cucumber-puppet

cucumber-puppet allows you writing behavioural tests for your puppet manifest.

## Getting started

Install cucumber-puppet

   $ gem install cucumber-puppet

Generate a new puppet project

   $ cucumber-puppet-gen project puppet

Configure your project and make sure puppet's site.pp is found

   $ cd puppet
   $ vim features/support/hooks.rb

Create a feature "bar" for your puppet module "foo"

   $ ./bin/cucumber-puppet-gen feature foo bar

Run that feature

   $ ./bin/cucumber-puppet features/foo/bar.feature

cucumber-puppet is based upon
[Lindsay Holmwood's](http://holmwood.id.au/~lindsay/)
[cucumber-nagios](http://auxesis.github.com/cucumber-nagios/).
