Given /^a working directory of "([^\"]*)"$/ do |dir|
  dir.split('/').each do |d|
    Dir.mkdir(d)
    Dir.chdir(d)
  end
end

Then /^feature "([^\"]*)" should exist in "([^\"]*)"$/ do |feature, path|
  @featurefile = "#{path}/#{feature}.feature"
  fail unless File.exists?(@featurefile)
end

Then /^it should contain "([^\"]*)"$/ do |content|
  featurefile = File.open(@featurefile)
  fail unless featurefile.grep(/#{content}/).length > 0
  featurefile.close
end
