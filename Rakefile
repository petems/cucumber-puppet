require 'rubygems'

require 'cucumber/rake/task'
require 'tmpdir'

cucumber_opts = %w{--require features --format progress}
Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = [cucumber_opts, '--tags', '~@puppet_version']
end

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = %w{--color --format progress}
end

desc "build gem"
task :build => [:build_docs] do
  sh("gem build cucumber-puppet.gemspec")
  exit 1 unless File.exists?(Dir.glob("cucumber-puppet-*.gem").to_s)

  FileUtils.mkdir_p('pkg')
  puts
  Dir.glob("cucumber-puppet-*.gem").each do |gem|
    dest = File.join('pkg', gem)
    FileUtils.mv(gem, dest)
    puts "New gem in #{dest}"
  end
end

desc "build documentation"
task :build_docs do
  manpages = Dir.glob("man/*.ronn")
  manpages.each do |m|
    sh("ronn -b #{m}")
  end
end

desc "install gem"
task :install do
  filenames = Dir.glob("pkg/*.gem")
  filenames_with_times = filenames.map do |filename|
    [filename, File.mtime(filename)]
  end

  newest = filenames_with_times.sort_by { |tuple| tuple.last }.last
  newest_filename = newest.first

  sh("gem install #{newest_filename}")
end

desc "push gem"
task :push => [:tests] do
  filenames = Dir.glob("pkg/*.gem")
  filenames_with_times = filenames.map do |filename|
    [filename, File.mtime(filename)]
  end

  newest = filenames_with_times.sort_by { |tuple| tuple.last }.last
  newest_filename = newest.first

  sh("gem push #{newest_filename}")
end

desc "run test suite of puppet features"
task :testsuite do
  testsuite = Dir.mktmpdir
  begin
    Dir.chdir(testsuite)
    basedir = File.dirname(__FILE__)

    sh("ruby -I#{basedir}/lib #{basedir}/bin/cucumber-puppet-gen world > /dev/null")
    sh("ruby -I#{basedir}/lib #{basedir}/bin/cucumber-puppet-gen testsuite --force > /dev/null")
    sh("ruby -I#{basedir}/lib #{basedir}/bin/cucumber-puppet --format progress features")
  ensure
    Dir.chdir(basedir)
    FileUtils.remove_entry_secure testsuite
  end
end

desc "run all tests"
task :tests => [:spec, :cucumber, :testsuite]

task :default => :tests

desc "uninstall gem"
task :uninstall do
  sh("gem uninstall -x cucumber-puppet")
end
