<%= "gem 'puppet', '#{version}'" if version %>
require 'cucumber-puppet/puppet'

World do
  CucumberPuppet.new
end
