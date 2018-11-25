require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs = ['lib', 'spec']
  t.options = '-v'
  t.test_files = FileList['spec/**/*_spec.rb']
end

task default: [:test]

namespace :db do
  task :prepare, :environment do |t, args|
    desc 'Set up the database index'

    args.with_defaults environment: 'development'
    ENV['RACK_ENV'] = args[:environment]

    require_relative 'lib/db/neography_connection'
    NeographyConnection.db.create_node_index 'movies'
  end
end
