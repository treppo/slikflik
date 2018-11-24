ENV['RACK_ENV'] = 'test'
ENV['TMDB_API_KEY'] ||= '12345'

require 'vcr_setup'

require 'test_database_connection'
TestDatabaseConnection.new.setup_index

require 'minitest/pride'
require 'minitest/autorun'
require 'minitest-spec-context'
require 'quacky'

Minitest.after_run do
  TestDatabaseConnection.new.teardown_index
end

class Minitest::Spec
  include Quacky::MiniTest::Matchers
end

# support test sharing through modules
class Module
  include Minitest::Spec::DSL
end
