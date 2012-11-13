# Pretty much every sh reference here needs to be converted to use
# the vagrant object, which is being partially used and will allow
# our windows friends to also use this functionality.
# -JDF (20121110)

require 'vagrant'
require 'fileutils'
require 'yaml'
require 'pp'

NODES_FILE = './config/nodes.yml'

baseboxes = Dir.glob("definitions/*").select { |f| File.directory?(f) }.map! do |e|
  e.gsub(/definitions\//, '')
end

debian = {
  :lenny_boxes   => baseboxes.grep(/debian-5/).sort,
  :squeeze_boxes => baseboxes.grep(/debian-6/).sort
}

commands = {
  :basebox => 'bundle exec vagrant basebox',
  :add     => 'bundle exec vagrant box add',
  :vagrant => 'bundle exec vagrant'
}

vagrant = Vagrant::Environment.new

namespace :vagrant do
  namespace :puppetmaster do
    desc "Turn on the Puppetmaster"
    task :up do
      sh %{#{commands[:vagrant]} up puppetmaster; true }
    end

    desc "Forcefully destroy the Puppetmaster"
    task :destroy do
      sh %{#{commands[:vagrant]} destroy puppetmaster -f; true }
    end

    desc "Restart the Puppetmaster (non-destructive)"
    task :reload do
      sh %{#{commands[:vagrant]} reload puppetmaster; true }
    end

    desc "Destroy and rebuild the Puppetmaster (destructive)"
    task :rebuild do
      sh %{#{commands[:vagrant]} destroy puppetmaster -f && #{commands[:vagrant]} up puppetmaster; true}
    end

    desc "Refresh the faux-dns on the PuppetMaster"
    task :reload_dns do
      puts "Reloading PuppetMaster 2x to Reload/Distribute DNS Resources..."
      sh %{#{commands[:vagrant]} provision puppetmaster && #{commands[:vagrant]} provision puppetmaster}
    end

    desc "Provision the PuppetMaster (DNS Refresh, et. al)"
    task :provision do
      puts "Reloading the PuppetMaster...."
      sh %{#{commands[:vagrant]} provision puppetmaster; true }
    end

    namespace :certs do
      desc "Delete all certificates with [<host>]"
      task :delete, :name do |t, args|
        name = args[:name]
        vagrant.vms[:puppetmaster].channel.sudo("find /etc/puppet/ssl -type f | grep #{name} | xargs rm -rf")
      end
    end
  end

  namespace :node do
    desc "Initialize a base nodes.yml"
    task :initialize do
      if !File.exists?(NODES_FILE)
        FileUtils.cp('./config/autogen_defaults.yml', NODES_FILE)
      end
    end

    desc "Re-initizlie a base nodes.yml (destructive)"
    task :reinitialize do
      FileUtils.rm(NODES_FILE) if File.exists?(NODES_FILE)
      Rake::Task["vagrant:node:initialize"].invoke
    end

    desc "Add node [<node>] to nodes.yml with [<vbox> (default from &default)] "
    task :add, :name, :vbox do |t, args|
      name = args[:name]

      nodes = YAML::load(File.open(NODES_FILE))

      if !nodes.has_key?(name)
        network = nodes['default']['ip'].split('.')[0..2].join('.')
        highest_used_ip = nodes.collect {|k,v| v['ip'].split('.')[3].to_i }.sort.last
        vbox = args[:vbox] || nodes['default']['vbox']

        new_node = nodes['default'].clone

        # Ensure Puppet Server Provisioner and Custom VBox are added
        new_node['puppet_server'] = nil
        new_node['vbox'] = vbox
        new_node['ip'] = "#{network}.#{highest_used_ip+1}"

        # And give it back to the nodes file!
        nodes["#{name}"] = new_node

        File.open(NODES_FILE, 'w') { |f| f.write(nodes.to_yaml) }

        puts "Node #{name} has been added. Open #{NODES_FILE} to further customize"
      else
        puts "#{name} is already defined as:"
        puts nodes[name].to_yaml
      end
    end

    desc "Remove node [<node>] from nodes.yml"
    task :remove, :name do |t, args|
      name = args[:name]

      nodes = YAML::load(File.open(NODES_FILE))
      if nodes.has_key?(name)
        nodes.delete(name)
        File.open(NODES_FILE, 'w') { |f| f.write(nodes.to_yaml) }

        puts "Node #{name} has been removed from #{NODES_FILE}"
      else
        puts "#{name} is not defined"
      end
    end
  end

  desc "SSH into a host [<name>]"
  task :ssh, :name do |t, args|
    name = args[:name]
    sh %{#{commands[:vagrant]} ssh #{name}; true}
  end

  desc "Turn on vagrant node [<host>] and ensure PuppetMaster is ready"
  task :up, :name do |t, args|
    name = args[:name]
    Rake::Task["vagrant:puppetmaster:certs:delete"].invoke(name)
    sh %{#{commands[:vagrant]} up #{name}; true }
  end

  desc "Provision vagrant node [<host>] and ensure PuppetMaster is ready"
  task :provision, :name do |t, args|
    name = args[:name]
    Rake::Task["vagrant:puppetmaster:certs:delete"].invoke(name)
    sh %{#{commands[:vagrant]} provision #{name}; true}
  end

  desc "Restart vagrant node [<host>]"
  task :reload, :name do |t, args|
    name = args[:name]
    sh %{#{commands[:vagrant]} reload #{name}; true}
  end

  desc "Forcefully destroy vagrant node [<node>]"
  task :destroy, :name do |t, args|
    name = args[:name]
    sh %{#{commands[:vagrant]} destroy #{name} -f; true}
  end

  desc "Destroy and rebuild vagrant node [<host>] (destructive)"
  task :rebuild, :name do |t, args|
    name = args[:name]
    Rake::Task["vagrant:puppetmaster:certs:delete"].invoke(name)
    sh %{#{commands[:vagrant]} destroy #{name} -f && #{commands[:vagrant]} up #{name}; true}
  end

  namespace :basebox do
    namespace :build do
      desc "Build all available Baseboxes"
      task :all do
        baseboxes.each { |basebox| Rake::Task["vagrant:basebox:build:#{basebox}"].invoke }
      end
      desc "Build latest Debian Squeeze Basebox"
      task :squeeze do
        sh %{#{commands[:basebox]} build #{debian[:squeeze_boxes].first} --force --auto}
        sh %{#{commands[:basebox]} export #{debian[:squeeze_boxes].first}}
        sh %{#{commands[:add]} #{debian[:squeeze_boxes].first} #{debian[:squeeze_boxes].first}.box --force}
        sh %{rm #{debian[:squeeze_boxes].first}.box}
        sh %{#{commands[:basebox]} destroy #{debian[:squeeze_boxes].first}}
      end
      desc "Build latest Debian Lenny Basebox"
      task :lenny do
        sh %{#{commands[:basebox]} build #{debian[:lenny_boxes].first} --force --auto}
        sh %{#{commands[:basebox]} export #{debian[:lenny_boxes].first}}
        sh %{#{commands[:add]} #{debian[:lenny_boxes].first} #{debian[:lenny_boxes].first}.box --force}
        sh %{rm #{debian[:lenny_boxes].first}.box}
        sh %{#{commands[:basebox]} destroy #{debian[:lenny_boxes].first}}
      end
      baseboxes.each do |basebox|
        desc "Builds #{basebox} Vagrant Basebox"
        task basebox do
          sh %{#{commands[:basebox]} build #{basebox} --force --auto}
          sh %{#{commands[:basebox]} export #{basebox}}
          sh %{#{commands[:add]} #{basebox} #{basebox}.box --force}
          sh %{rm #{basebox}.box}
          sh %{#{commands[:basebox]} destroy #{basebox}}
        end
      end
    end
    namespace :list do
      desc "List all of the available basebox definitions"
      task :all do
        puts "The full list of basebox definitions are:\n\n"
        baseboxes.each do |basebox|
          puts "#{basebox}\n"
        end
      end
    end
  end
end

# Ensure Puppetmaster Modules are regenerated for each command,
# and the puppetmaster is up and running
['up', 'rebuild', 'provision', 'reload'].each do |t|
  task "vagrant:#{t}" => [
    'puppet:generate:modules',
    'vagrant:puppetmaster:up'
  ]
end

task "vagrant:basebox:build:all" => 'vagrant:node:initialize'

['add', 'remove'].each do |t|
  task "vagrant:node:#{t}" => 'vagrant:puppetmaster:reload_dns'
end

# Make sure a nodes.yml exists to be added to
task 'vagrant:node:add' => 'vagrant:node:initialize'

# Automatically generate node definitions
task 'vagrant:puppetmaster:up' => 'vagrant:node:initialize'
