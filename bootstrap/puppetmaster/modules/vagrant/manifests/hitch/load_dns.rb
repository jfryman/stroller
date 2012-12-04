require 'yaml'

hostclass 'vagrant::hitch::load_dns', :arguments => { "config" => AST::String.new(:value => "/etc/vagrant/hitch/nodes.yml") } do
  config = @config

  # In the event that this is instantiated on the PuppetMaster, load up
  # the Vagrant YAML config and grab out all known IP addresses, and virtualize them
  nodes = YAML::load(File.open(config))
  orgname = nodes['default'].has_key?('orgname') ? nodes['default']['orgname'] : "vagrant.dev"
  scope.find_definition('bind::a')

  nodes.each do |k,v|
    next if k == 'default'
    create_resource 'bind::a', "#{k}",:zone => "#{orgname}", :target => "#{v['ip']}"
  end
end
