require 'puppet'

# A class for accessing Puppet's internal state regarding a certain node or
# class.
class CucumberPuppet
  def initialize
    # resources' alias metaparameter
    @aliases = {}

    # default puppet configuration
    @puppetcfg = {
      'confdir' => "/etc/puppet",
      'manifest' => "/etc/puppet/manifests/site.pp",
    }

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
    if klass.class == String
      # XXX sth like klass.split(/,/) and remove whitespace
      @klass = klass.to_a
    elsif klass.class == Hash
      @klass = klass
    else
      raise "unsupported class #{klass.class} for klass."
    end
  end

  # Compile catalog for configured testnode.
  def compile_catalog( node = nil )
    Puppet.settings.handlearg("--confdir", @puppetcfg['confdir'])
    Puppet.parse_config
    # reset confdir in case it got overwritten
    @puppetcfg.each do |option,value|
      Puppet.settings.handlearg("--#{option}", value)
    end

    unless node.is_a?(Puppet::Node)
      node = Puppet::Node.new(@facts['hostname'], :classes => @klass)
      node.merge(@facts)
    end

    # Compile our catalog
    begin
      @catalog = Puppet::Resource::Catalog.indirection.find(node.name, :use_node => node)
    rescue NameError
      @catalog = Puppet::Node::Catalog.find(node.name, :use_node => node)
    end

    # XXX could not find this in puppet
    catalog_resources.each do |resource|
      next unless resource[:alias]
      resource[:alias].each_line do |a|
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
