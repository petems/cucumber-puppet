# A sample Guardfile
# More info at https://github.com/guard/guard#readme

group 'bdd' do
  guard 'cucumber' do
    watch(%r{^features/.+\.feature$})
    watch(%r{^features/support/.+$})     { 'features' }
    watch(%r{^features/steps/(.+)\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
  end
end

# testsuite
require 'guard/guard'
require 'tmpdir'

module ::Guard
  class Testsuite < ::Guard::Guard
    def start
      @basedir = File.dirname(__FILE__)
      @testsuite = Dir.mktmpdir
      Dir.chdir(@testsuite)
      system "ruby -I#{@basedir}/lib #{@basedir}/bin/cucumber-puppet-gen world"
      run_all
    end

    def stop
      FileUtils.remove_entry_secure @testsuite
    end

    def reload
      stop
      start
    end

    def run_all
      run_on_change('features')
    end

    def run_on_change(paths)
      if paths[0] == 'reload'
        reload
      else
        Dir.chdir(@testsuite)
        system "ruby -I#{@basedir}/lib #{@basedir}/bin/cucumber-puppet-gen testsuite --force"
        system "ruby -I#{@basedir}/lib #{@basedir}/bin/cucumber-puppet --format progress #{paths}"
      end
    end
  end
end

group :puppet do
  guard :testsuite do
    watch(%r{^lib/generators/world/.+\.rb$}) { 'reload' }
    watch(%r{^lib/generators/testsuite/(.+)\.feature$}) do |m|
      "#{m[1]}.feature"
    end
    watch(%r{^lib/generators/testsuite/classes/(.+)\.pp$}) do |m|
      feature = Dir[File.join("lib/generators/testsuite/**/#{m[1]}.feature")][0]
      if feature
        feature.gsub('lib/generators/testsuite/')
      else
        'features'
      end
    end
  end
end
