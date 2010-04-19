Then /^feature "([^\"]*)" for module "([^\"]*)" should exist$/ do |feature, mod|
  @featurefile = "features/modules/#{mod}/#{feature}.feature"
  fail unless File.exists?(@featurefile)
end

Then /^it should contain "([^\"]*)"$/ do |content|
  featurefile = File.open(@featurefile)
  fail unless featurefile.grep(/#{content}/).length > 0
  featurefile.close
end
