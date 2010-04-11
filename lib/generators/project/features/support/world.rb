require 'puppet'
require 'puppet/network/client'

class PuppetMock
  # object setup
  attr_accessor :confdir, :manifest

  # facter facts
  attr_accessor :architecture, :domain, :environment, :hostname
  attr_accessor :lsbdistcodename, :network_eth0, :operatingsystem

  def initialize()
    @confdir = "/etc/puppet"
    @manifest = @confdir + "/manifest/site.pp"

    # default facts
    @architecture = ""
    @domain = "no.domain"
    @environment = "production"
    @hostname = "testnode"
    @lsbdistcodename = ""
    @network_eth0 = "127.0.0.0"
    @operatingsystem = ""

    Puppet::Util::Log.newdestination(:console)
    Puppet::Util::Log.level = :notice
  end

  def debug()
    Puppet::Util::Log.level = :debug
  end

  def set_klass(klass)
    @klass = klass.to_a
  end

  def compile_catalog()
    Puppet[:confdir] = @confdir
    Puppet[:manifest] = @manifest
    Puppet.parse_config

    node = Puppet::Node.new(@hostname, :classes => @klass)
    node.merge({
      "architecture" => @architecture,
      "domain" => @domain,
      "environment" => @environment,
      "hostname" => @hostname,
      "lsbdistcodename" => @lsbdistcodename,
      "network_eth0" => @network_eth0,
      "operatingsystem" => @operatingsystem,
    })

    begin
      # Compile our catalog
      @catalog = Puppet::Node::Catalog.find(node.name, :use_node => node)
    rescue => detail
      if Puppet[:trace]
        puts detail.backtrace
      end
      if detail.is_a?(XMLRPC::FaultException)
        $stderr.puts detail.message
      else
        $stderr.puts detail
      end
      exit 1
    end
  end

  def resource(title)
    resource = @catalog.resource(title)
    return resource
  end
end

World do
  PuppetMock.new
end
