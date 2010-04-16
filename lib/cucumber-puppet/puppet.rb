require 'puppet'
require 'puppet/network/client'

class CucumberPuppet
  def initialize
    @confdir = "/etc/puppet"
    @manifest = @confdir + "/manifest/site.pp"

    # default facts
    @facts = {
      'architecture' => "",
      'domain' => "no.domain",
      'environment' => "production",
      'hostname' => "testnode",
      'lsbdistcodename' => "",
      'network_eth0' => "127.0.0.0",
      'operatingsystem' => "",
    }

    Puppet::Util::Log.newdestination(:console)
    Puppet::Util::Log.level = :notice
  end

  def debug
    Puppet::Util::Log.level = :debug
  end

  def klass=(klass)
    @klass = klass.to_a
  end

  def compile_catalog
    Puppet[:confdir] = @confdir
    Puppet[:manifest] = @manifest
    Puppet.parse_config

    node = Puppet::Node.new(@facts['hostname'], :classes => @klass)
    node.merge(@facts)

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
