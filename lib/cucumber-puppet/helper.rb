require 'cucumber-puppet'

# Private helper methods.
module CucumberPuppet::Helper
  private

  # Finds the root of the puppet directory tree according to Puppet's
  # directory naming convention. Relevant sub-trees are:
  #
  # - <puppetdir>/features/modules/$module
  # - <puppetdir>/modules/$module/features
  #
  # In case no tree is identified, assumes cwd is <puppetdir>.
  def find_root
    cwd = Dir.getwd
    path = cwd.split('/')

    if cwd.match('features$') and not cwd.match("modules/")
      # <puppetdir>/features
      path.pop
    elsif cwd.match('features/modules$')
      # <puppetdir>/features/modules
      path.pop
      path.pop
    elsif cwd.match('features/modules/[^/]*$')
      # <puppetdir>/features/modules/$module
      path.pop
      path.pop
      path.pop
    elsif cwd.match('modules$')
      # <puppetdir>/modules
      path.pop
    elsif cwd.match('/modules/[^/]*$')
      # <puppetdir>/modules/$module
      path.pop
      path.pop
    elsif cwd.match('/modules/[^/]*/features$')
      # <puppetdir>/modules/$module/features
      path.pop
      path.pop
      path.pop
    end

    path.join('/')
  end

  # Finds the destination path for feature files to install according to
  # puppet's directory naming convention.
  def find_destdir(mod)
    cwd = Dir.getwd

    if cwd.match("features$") and not cwd.match("modules/")
      # <puppetdir>/features
      destdir = "modules/#{mod}"
    elsif cwd.match("features/modules$")
      # <puppetdir>/features/modules
      destdir = mod
    elsif cwd.match("features/modules/#{mod}$")
      # <puppetdir>/features/modules/$mod
      destdir = "."
    elsif cwd.match("modules$")
      # <puppetdir>/modules
      destdir = "#{mod}/features"
    elsif cwd.match("modules/#{mod}$")
      # <puppetdir>/modules/$mod
      destdir = "features"
    elsif cwd.match("modules/#{mod}/features$")
      # <puppetdir>/modules/$mod/features
      destdir = "."
    else
      # <puppetdir>
      destdir = "features/modules/#{mod}"
    end

    destdir
  end
end
