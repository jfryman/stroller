require 'yaml'

nodes = YAML::load(File.open(NODES_FILE))
modules_path = nodes['puppetmaster']['mounts']['puppet_modules']['host']
manifests_path = nodes['puppetmaster']['mounts']['puppet_manifests']['host']

namespace :puppet do
  namespace :generate do
    desc "Generate modules.pp while refactoring for autoloading"
    task :modules do
      File.open(File.expand_path("#{manifests_path}/modules.pp", 'w')) do |file|
        Dir[("#{modules_path}/*/manifests/init.pp")].entries.each do |path|
          module_name = path.split('/')[1]
          file.puts "import '#{module_name}'"
        end
      end
    end
  end
end
