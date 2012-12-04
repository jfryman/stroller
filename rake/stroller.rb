require 'yaml'

nodes = YAML::load(File.open(NODES_FILE))

namespace :stroller do
  desc "Set the Orgname for Stroller"
  task :orgname, :domain do |t, args|
    nodes['default']['orgname'] = args[:domain] || 'vagrant.dev'
    File.open(NODES_FILE, 'w') { |f| f.write(nodes.to_yaml) }
  end
end
