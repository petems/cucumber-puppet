Given /^cucumber\-puppet is installed$/ do
  steps %Q{
    When I build the gem
    And I install the latest gem
    Then I should have cucumber-puppet-gen in my PATH
  }
end

When /^I create a new project called "([^\"]*)"$/ do |project|
  @project = project
  fail if File.exists?("/tmp/#{@project}")
  fail unless system("cd /tmp && cucumber-puppet-gen project #{@project}")
end

When /^I freeze in dependencies$/ do
  @project.should_not be_nil
end

