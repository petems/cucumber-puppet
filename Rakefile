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

desc "install gem"
task :install do
  filenames = Dir.glob("pkg/*.gem")
  filenames_with_times = filenames.map do |filename|
    [filename, File.mtime(filename)]
  end

  oldest = filenames_with_times.sort_by { |tuple| tuple.last }.last
  oldest_filename = oldest.first

  system("gem install #{oldest_filename}")
end

desc "uninstall gem"
task :uninstall do
  system("gem uninstall -x cucumber-puppet")
end
