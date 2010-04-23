desc 'Run cucumber-puppet features'
task :cucumber_puppet do
  command = []
  command << "cucumber-puppet"
  command << "features"
  command << Dir.glob("modules/**/features")
  exit 1 unless system(command.join(' '))
end
