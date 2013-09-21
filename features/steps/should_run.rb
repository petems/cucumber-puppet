Then /^cucumber\-puppet should successfully run "([^\"]*)"$/ do |feature|
  basedir = File.dirname(__FILE__) + '/../..'
  command = "ruby -I#{basedir}/lib #{basedir}/bin/cucumber-puppet -b #{feature}"
  output = `#{command}`
  if $?.to_i > 0
     puts output
     fail
   end
end