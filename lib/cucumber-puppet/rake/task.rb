desc 'Run cucumber-puppet features'
task :cucumber_puppet do
  exit 1 unless system("cucumber-puppet features")
end
