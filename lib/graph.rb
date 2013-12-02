require 'neography'

Neography.configure do |config|
  database_config = YAML.load_file('config/database.yml')[ENV['RACK_ENV']]
  config.server = database_config['server']
  config.port = database_config['port']
end

class Graph

  def get_nodes ids
    ids.flat_map(&get_node)
  end

  def get_connection nodes
    database.get_node_relationships_to(*nodes)
  end

  def connect nodes
    database.create_relationship 'connection', *nodes, weight: 0
  end

  def increase_weight connection
    set_weight connection, get_weight(connection) + 1
  end

  def add units
    units.map(&create_unique_node)
  end

  def find_neighbors ids
    ids.flat_map do |id|
      database.execute_query("
        START movie=node:movies(id = '#{id}')
        MATCH (movie)--(neighbor)
        RETURN neighbor.id
      ").fetch('data').flatten
    end.uniq - ids
  end

  private

  def get_node
    ->(id) do
      database.find_node_index 'movies', 'id', id
    end
  end

  def get_weight connection
    database.get_relationship_properties(connection, 'weight')['weight']
  end

  def set_weight connection, weight
    database.set_relationship_properties connection, weight: weight
  end

  def create_unique_node
    ->(unit) do
      index_name = 'movies'
      key = 'id'
      unique_value = unit.fetch :id
      database.create_unique_node index_name, key, unique_value, unit
    end
  end

  def database
    @_db ||= Neography::Rest.new
  end
end
