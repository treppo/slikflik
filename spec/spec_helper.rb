ENV['RACK_ENV'] = 'test'
ENV['TMDB_API_KEY'] ||= '12345'

require 'vcr_setup'

require 'test_database_connection'
TestDatabaseConnection.new.setup_index

require 'minitest/pride'
require 'minitest/autorun'
require 'minitest-spec-context'

Minitest.after_run do
  TestDatabaseConnection.new.teardown_index
end

# support test sharing through modules
class Module
  include Minitest::Spec::DSL
end
