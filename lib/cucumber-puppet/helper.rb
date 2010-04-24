require 'cucumber-puppet'

module CucumberPuppet::Helper
  # Finds the root of the puppet directory tree according to puppet's
  # directory naming conventions. Relevant sub-trees are:
  # - <puppetdir>/features/modules/$module
  # - <puppetdir>/modules/$module/features
  # In case no tree is identified, assumes cwd is <puppetdir>.
  def find_root(cwd)
    path = cwd.split('/')
    if cwd.match('features$') and not cwd.match("modules/")
      # <puppetdir>/features
      path.pop
    elsif cwd.match('features/modules$')
      # <puppetdir>/features/modules
      path.pop(2)
    elsif cwd.match('features/modules/[^/]*$')
      # <puppetdir>/features/modules/$module
      path.pop(3)
    elsif cwd.match('modules$')
      # <puppetdir>/modules
      path.pop
    elsif cwd.match('/modules/[^/]*$')
      # <puppetdir>/modules/$module
      path.pop(2)
    elsif cwd.match('/modules/[^/]*/features$')
      # <puppetdir>/modules/$module/features
      path.pop(3)
    end
    path.join('/')
  end
end
