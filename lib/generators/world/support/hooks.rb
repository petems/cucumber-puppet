Before do
  # adjust local configuration like this
  # @puppetcfg['confdir']  = File.join(File.dirname(__FILE__), '..', '..')
  # @puppetcfg['manifest'] = File.join(@puppetcfg['confdir'], 'manifests', 'site.pp')
  # @puppetcfg['modulepath']  = "/srv/puppet/modules:/srv/puppet/site-modules"

  # adjust facts like this
  @facts['architecture'] = "i386"
end
