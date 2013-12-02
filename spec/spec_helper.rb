ENV['RACK_ENV'] = 'test'

if ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end

  require 'coveralls'
  Coveralls.wear!
end

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
