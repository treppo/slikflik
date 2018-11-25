require "db/neography_connection"

class TestDatabaseConnection
  extend Forwardable

  attr_reader :db

  def_delegators :db, :create_nodes

  def initialize
    @db ||= NeographyConnection.db
  end

  def reset
    db.execute_query("MATCH (n) DETACH DELETE n")
  end

  def setup_index
    db.create_node_index "movies"
  end

  def teardown_index
    db.drop_node_index "movies"
  end
end
