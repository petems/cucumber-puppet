require 'cucumber-puppet/helper'
include CucumberPuppet::Helper

describe 'CucumberPuppet::Helper' do
  describe '.find_destdir' do
    paths = {
      'puppet' => 'features/modules/foo',
      'puppet/features' => 'modules/foo',
      'puppet/features/modules' => 'foo',
      'puppet/features/modules/foo' => '.',
      'puppet/modules' => 'foo/features',
      'puppet/modules/foo' => 'features',
      'puppet/modules/foo/features' => '.',
    }
    paths.each do |cwd, dest|
      it "should return #{dest} for #{cwd}" do
        Dir.stub(:getwd).and_return(cwd)
        destdir = find_destdir("foo")
        destdir.should == dest
      end
    end
  end

  describe '.find_root' do
    paths = [
      'puppet', 'puppet/modules', 'puppet/modules/foo',
      'puppet/modules/foo/features', 'puppet/features',
      'puppet/features/modules', 'puppet/features/modules/foo'
    ]
    paths.each do |p|
      it "should return 'puppet' for #{p}" do
        Dir.stub(:getwd).and_return(p)
        root = find_root
        root.should == 'puppet'
      end
    end
  end
end
