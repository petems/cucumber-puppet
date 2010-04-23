Then /^cucumber\-puppet should successfully run "([^\"]*)"$/ do |feature|
  basedir = File.dirname(__FILE__) + '/../..'
  output = `ruby #{basedir}/bin/cucumber-puppet #{feature}`
  if $?.to_i > 0
    puts output
    fail
  end
end
