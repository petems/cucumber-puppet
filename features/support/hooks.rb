After do
  if @dir and File.directory?(@dir)
    Dir.chdir(@oldwd)
    FileUtils.remove_entry_secure @dir
  end
end
