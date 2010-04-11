When /^I build the gem$/ do
  project_root = File.join(File.dirname(__FILE__), '..', '..')
  rakefile = File.join(project_root, 'Rakefile')
  fail unless File.exist?(rakefile)
  specfile = File.join(project_root, 'cucumber-puppet.gemspec')
  fail unless File.exist?(specfile)
  fail unless system("rake -f #{rakefile} build > /dev/null")
end

When /^I install the latest gem$/ do
  project_root = File.join(File.dirname(__FILE__), '..', '..')
  pkg_dir = File.join(project_root, 'pkg')
  pkg = File.expand_path(Dir.glob(File.join(pkg_dir, '*.gem')).last)

  fail unless system("gem install #{pkg} > /dev/null 2>&1")
end

Then /^I should have cucumber\-puppet\-gen in my PATH$/ do
  fail unless system("which cucumber-puppet-gen")
end
