Given /^cucumber\-puppet is installed$/ do
  steps %Q{
    When I build the gem
    And I install the latest gem
    Then I should have cucumber-puppet-gen in my PATH
  }
end

When /^I create a new project called "([^\"]*)"$/ do |project|
  @project = "/tmp/#{project}"
  fail if File.exists?(@project)
  fail unless system("cd /tmp && cucumber-puppet-gen project #{project}")
end

When /^I freeze in dependencies$/ do
  fail unless system("cd #{@project} && gem bundle")
end

Then /^my gems directory should be populated$/ do
  Dir.glob("#{@project}/vendor/gems/*").size.should > 0
end
