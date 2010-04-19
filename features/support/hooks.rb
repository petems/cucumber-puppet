After do
  Dir.chdir(@oldwd)
  FileUtils.remove_entry_secure @dir
end
