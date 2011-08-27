Before do
  @puppetcfg['confdir']  = File.join(File.dirname(__FILE__), '..', '..')
  @puppetcfg['manifest'] = File.join(@puppetcfg['confdir'], 'site.pp')
end
