require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs = ['lib', 'spec']
  t.options = '-v'
  t.test_files = FileList['spec/**/*_spec.rb']
end

task default: [:test]

namespace :db do
  task :prepare do
    require 'neography'

    Neography.configure do |config|
      database_config = YAML.load_file('config/database.yml')[ENV['RACK_ENV'] || 'development']
      config.server = database_config['server']
      config.port = database_config['port']
    end

    Neography::Rest.new.create_node_index 'movies'
  end
end
