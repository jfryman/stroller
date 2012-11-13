namespace :puppet do
  namespace :generate do
    desc "Generate modules.pp while refactoring for autoloading"
    task :modules do
      File.open('manifests/modules.pp', 'w') do |file|
        Dir["modules/*/manifests/init.pp"].entries.each do |path|
          module_name = path.split('/')[1]
          file.puts "import '#{module_name}'"
        end
      end
    end
  end
end
