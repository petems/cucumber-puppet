require 'puppet'
require 'puppet/network/client'

# A class for accessing Puppet's internal state regarding a certain node or
# class.
class CucumberPuppet
  # Returns a new CucumberPuppet object.
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

  # Set Puppet's log level to 'debug'.
  def debug
    Puppet::Util::Log.level = :debug
  end

  # Define Puppet classes to include in a feature's testnode.
  def klass=(klass)
    # XXX sth like klass.split(/,/) and remove whitespace
    @klass = klass.to_a
  end

  # Compile catalog for configured testnode.
  #
  #   @confdir defaults to '/etc/puppet'
  #   @manifest defaults to @confdir + '/manifests/site.pp'
  #
  def compile_catalog( node = nil )
    Puppet.settings.handlearg("--confdir", @confdir)
    Puppet.parse_config
    # reset confdir in case it got overwritten
    Puppet.settings.handlearg("--confdir", @confdir)
    Puppet.settings.handlearg("--manifest", @manifest)

    unless node.is_a?(Puppet::Node)
      node = Puppet::Node.new(@facts['hostname'], :classes => @klass)
      node.merge(@facts)
    end

    begin
      # Compile our catalog
      begin
        @catalog = Puppet::Resource::Catalog.find(node.name, :use_node => node)
      rescue NameError
        @catalog = Puppet::Node::Catalog.find(node.name, :use_node => node)
      end
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

  # Returns an Object with the given title from catalog.
  def get_resource(title)
    @catalog.resource(title)
  end
  # XXX add deprecation warning for resource()
  def resource(title)
    get_resource(title)
  end

end
