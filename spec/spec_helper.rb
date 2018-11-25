require "vcr_setup"
require "test_database_connection"
require "minitest/pride"
require "minitest/autorun"
require "minitest-spec-context"

ENV["RACK_ENV"] = "test"
ENV["TMDB_API_KEY"] ||= "12345"

TestDatabaseConnection.new.setup_index

Minitest.after_run do
  TestDatabaseConnection.new.teardown_index
end

class Module
  include Minitest::Spec::DSL
end
