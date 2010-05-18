Then /^"([^\"]*)" should be in groups? "([^\"]*)"$/ do |user, groups|
  steps %Q{
    Then there should be a resource "User[#{user}]"
    And the user should be in groups "#{groups}"
  }
end

Then /^the user should be in groups "([^\"]*)"$/ do |groups|
  g = @resource["groups"]
  g_s = g
  if g.is_a?(Array)
    g_s = g.join(' ')
  end
  fail unless g_s == groups
end
