When /^I build the gem$/ do
  project_root = File.join(File.dirname(__FILE__), '..', '..')
  rakefile = File.join(project_root, 'Rakefile')
  fail unless File.exist?(rakefile)
  fail unless system("rake -f #{rakefile} build")
end
