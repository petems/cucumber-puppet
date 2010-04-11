After do
  if File.exists?("/tmp/#{@project}")
    FileUtils.rm_rf("/tmp/#{@project}")
  end
  system("gem uninstall -x cucumber-puppet")
end
