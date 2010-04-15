Then /^the user should be in groups "([^\"]*)"$/ do |groups|
  fail unless @resource["groups"] == groups
end
