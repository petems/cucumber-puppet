begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "cucumber-puppet"
    gemspec.summary = "Puppet manifest testing with Cucumber"
    gemspec.description = "cucumber-puppet allows you writing behavioural tests for your puppet manifest"
    gemspec.email = "sturm@nistu.de"
    gemspec.homepage = "http://github.com/nistude/cucumber-puppet/"
    gemspec.authors = ["Nikolay Sturm"]
    gem.rubyforge_project = "cucumber-puppet"

    gem.add_dependency 'cucumber', '>= 0.6.4'
    gem.add_dependency 'templater', '>= 1.0'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

desc "build gem"
task :build do 
  exit 1 unless system("gem build cucumber-puppet.gemspec")
  exit 1 unless File.exists?(Dir.glob("cucumber-puppet-*.gem").to_s)

  FileUtils.mkdir_p('pkg')
  puts
  Dir.glob("cucumber-puppet-*.gem").each do |gem|
    dest = File.join('pkg', gem)
    FileUtils.mv(gem, dest)
    puts "New gem in #{dest}"
  end
end

