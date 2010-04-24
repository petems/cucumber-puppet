require 'cucumber-puppet/helper'
include CucumberPuppet::Helper

describe 'CucumberPuppet::Helper' do
  describe '.find_root' do
    paths = [
      'puppet', 'puppet/modules', 'puppet/modules/foo',
      'puppet/modules/foo/features', 'puppet/features',
      'puppet/features/modules', 'puppet/features/modules/foo'
    ]
    paths.each do |p|
      it "should return puppet for #{p}" do
        root = find_root(p)
        root.should == 'puppet'
      end
    end
  end
end
