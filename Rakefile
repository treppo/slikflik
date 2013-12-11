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

    url = ENV['NEO4J_URL'] || YAML.load_file('config/database.yml')[ENV['RACK_ENV']]['url']
    Neography::Rest.new(url).create_node_index 'movies'
  end
end
