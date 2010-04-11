After do
  if File.exists?(@project)
    FileUtils.rm_rf(@project)
  end
  system("gem uninstall -x cucumber-puppet")
end
