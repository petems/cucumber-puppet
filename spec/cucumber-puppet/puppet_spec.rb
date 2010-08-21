require 'spec_helper'
require 'cucumber-puppet/puppet'

# ensure existence of different version's API
module Puppet
  class Node
    class Catalog
    end
  end
  class Resource
    class Catalog
    end
  end
end

# to access some instance variables
class TestCucumberPuppet < CucumberPuppet
  attr_accessor :catalog
  attr_reader :facts, :klass
end

describe CucumberPuppet do
  describe 'a new object' do
    it 'should set puppet`s logdestination to console' do
      Puppet::Util::Log.should_receive(:newdestination).with(:console)
      TestCucumberPuppet.new
    end
    it 'should set puppet`s loglevel to notice' do
      Puppet::Util::Log.should_receive(:level=).with(:notice)
      TestCucumberPuppet.new
    end
  end

  describe '#debug' do
    it 'should set puppet`s loglevel to debug' do
      c = TestCucumberPuppet.new
      Puppet::Util::Log.should_receive(:level=).with(:debug)
      c.debug
    end
  end

  describe '#klass=' do
    # TODO add support for multiple classes by splitting the string
    it 'should create the array of classes from a string' do
      c = TestCucumberPuppet.new
      c.klass = "foo"
      c.klass.should == ["foo"]
    end
  end

  describe '#compile_catalog' do
    let(:c) { TestCucumberPuppet.new }

    before(:each) do
      Puppet.stub(:parse_config)
      @node = mock("node", :name => 'testnode').as_null_object
      @node.stub(:is_a?).and_return(Puppet::Node)
      Puppet::Node.stub(:new).and_return(@node)
      Puppet::Resource::Catalog.stub(:find)
    end

    it 'should parse the puppet config' do
      Puppet.should_receive(:parse_config)
      c.compile_catalog
    end
    it 'should merge facts into the node' do
      @node.should_receive(:merge).with(c.facts)
      c.compile_catalog
    end
    it 'should not merge facts into the node, if called with a node object' do
      @node.should_not_receive(:merge)
      c.compile_catalog(@node)
    end
    it 'should find the node`s catalog' do
      Puppet::Resource::Catalog.should_receive(:find).with(@node.name, :use_node => @node)
      c.compile_catalog
    end
    it 'should fall back to puppet`s 0.24 interface in case of NameError' do
      Puppet::Resource::Catalog.stub(:find).and_raise(NameError)
      Puppet::Node::Catalog.should_receive(:find).with(@node.name, :use_node => @node)
      c.compile_catalog
    end
  end

  describe '#get_resource' do
    it 'should return an entry from the catalog' do
      c = TestCucumberPuppet.new
      c.catalog = mock("catalog").as_null_object
      c.catalog.should_receive(:resource).with("foo")
      c.get_resource("foo")
    end
  end
end
