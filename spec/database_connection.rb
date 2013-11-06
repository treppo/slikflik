require 'neography'

database_config = YAML.load_file('config/database.yml')['test']

Neography.configure do |config|
  config.server = database_config['server']
  config.port = database_config['port']
end

class DatabaseConnection
  attr_reader :db

  def initialize
    @db = Neography::Rest.new
  end

  def reset
    db.execute_query("START n0=node(0),nx=node(*) MATCH n0-[r0?]-(),nx-[rx?]-() WHERE nx <> n0 DELETE r0,rx,nx")
  end

  def nodes_count
    db.execute_query("START n = node(*) RETURN count(*)")['data'].first.first
  end
end
