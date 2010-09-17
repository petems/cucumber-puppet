<%=
if version
  "begin
    gem 'puppet', '#{version}'
  rescue Gem::LoadError => e
    puts e
    exit 1
  end"
end
%>
require 'cucumber-puppet/puppet'
require 'cucumber-puppet/steps'

World do
  CucumberPuppet.new
end
