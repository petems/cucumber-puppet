Then /^a testcase should have been set up$/ do
  fail unless File.exist?("features/modules/testcase/testcase.feature")
  fail unless File.exist?("site.pp")
end
