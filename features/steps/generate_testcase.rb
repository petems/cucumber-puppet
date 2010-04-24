Then /^a testcase should have been set up$/ do
  fail unless File.exists?("features/modules/testcase/testcase.feature")
  fail unless File.exists?("features/modules/testcase/site.pp")
end
