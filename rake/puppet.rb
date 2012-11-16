require 'yaml'

nodes = YAML::load(File.open(NODES_FILE))
modules_path = File.expand_path(nodes['puppetmaster']['mounts']['puppet_modules']['host'])
manifests_path = File.expand_path(nodes['puppetmaster']['mounts']['puppet_manifests']['host'])

namespace :puppet do
  namespace :generate do
    desc "Generate modules.pp while refactoring for autoloading"
    task :modules do
      begin
        File.open("#{manifests_path}/modules.pp", 'w') do |file|
          Dir[("#{modules_path}/*/manifests/init.pp")].entries.each do |path|
            module_name = path.split('/')
            file.puts "import '#{module_name[module_name.size - 3]}'"
          end
        end
      rescue => e
        puts e
      end
    end
  end
end
