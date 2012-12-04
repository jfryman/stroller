require 'yaml'

module Puppet::Parser::Functions
  newfunction(:stroller_orgname, :type => :rvalue) do |args|
    node_file = '/etc/vagrant/hitch/nodes.yml'

    if File.exists? node_file
      nodes = YAML::load(File.open(node_file))
      nodes['default'].has_key?('orgname') ? nodes['default']['orgname'] : "vagrant.dev"
    else
      'vagrant.dev'
    end
  end
end
