require 'neography'

database_config = YAML.load_file('config/database.yml')['test']

Neography.configure do |config|
  config.server = database_config['server']
  config.port = database_config['port']
end

class TestDatabaseConnection

  extend Forwardable

  attr_reader :db

  def_delegators :db, :create_nodes

  def initialize
    @db = Neography::Rest.new
  end

  def reset
    db.execute_query("START n0=node(0),nx=node(*) MATCH n0-[r0?]-(),nx-[rx?]-() WHERE nx <> n0 DELETE r0,rx,nx")
  end

  def setup_index
    db.create_node_index 'movies'
  end

  def teardown_index
    db.drop_node_index 'movies'
  end
end
