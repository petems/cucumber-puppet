require 'cucumber-puppet'

module CucumberPuppet::Helper
  def find_root(cwd)
    path = cwd.split('/')
    if cwd.match('modules$') and not cwd.match('/features/')
      path.pop
    elsif cwd.match('/modules/[^/]*$') and not cwd.match('/features/')
      path.pop(2)
    elsif cwd.match('/modules/[^/]*/features$')
      path.pop(3)
    elsif cwd.match('features$')
      path.pop
    elsif cwd.match('features/modules$')
      path.pop(2)
    elsif cwd.match('features/modules/[^/]*$')
      path.pop(3)
    end
    path.join('/')
  end
end
