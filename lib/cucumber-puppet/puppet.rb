require 'puppet'
require 'puppet/network/client'

# A class for accessing Puppet's internal state regarding a certain node or
# class.
class CucumberPuppet
  # Returns a new CucumberPuppet object.
  def initialize
    # resources' alias metaparameter
    @aliases = {}

    @confdir = "/etc/puppet"
    @manifest = @confdir + "/manifests/site.pp"

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

    # XXX could not find this in puppet
    catalog_resources.each do |resource|
      next unless resource[:alias]
      resource[:alias].each do |a|
        # "foo" -> "Package[foo]"
        @aliases["#{resource.type}[#{a}]"] = resource
      end
    end
  end

  # Returns an Object with the given title from catalog, taking aliases
  # into account.
  def resource(title)
    @catalog.resource(title) || @aliases[title]
  end

  # Returns an Array with the catalog's Puppet::Resource objects.
  def catalog_resources
    # This method exists to supply a common interface to the puppet catalog
    # for different versions of puppet.
    @catalog.resources.map do |r|
      if r.is_a?(String)
        # puppet 0.25 and older
        resource(r)
      elsif r.is_a?(Puppet::Resource)
        # puppet 2.6 and newer
        r
      else
        raise "Unknown resource object #{r.class}"
      end
    end
  end
end
