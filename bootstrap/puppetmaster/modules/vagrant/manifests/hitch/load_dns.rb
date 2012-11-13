require 'yaml'

hostclass 'vagrant::hitch::load_dns', :arguments => { "config" => AST::String.new(:value => "/etc/vagrant/hitch/nodes.yml") } do
  config = @config

  # In the event that this is instantiated on the PuppetMaster, load up
  # the Vagrant YAML config and grab out all known IP addresses, and virtualize them
  nodes = YAML::load(File.open(config))
  orgname = nodes['default'].has_key?('orgname') ? nodes['default']['orgname'] : "vagrant.dev"

  nodes.each do |k,v|
    next if k == 'default'
    virtual do
      host "#{k}.#{orgname}",
        :ensure       => 'present',
        :ip           => v['ip'],
        :host_aliases => k,
        :tag          => 'vagrant:hitch:dns'
      end
  end

  # Make sure that the importer also includes the realization of
  # all of these hosts
  include 'vagrant::hitch::realize_dns'
end
