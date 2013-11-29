require 'neography'

Neography.configure do |config|
  database_config = YAML.load_file('config/database.yml')['development']
  config.server = database_config['server']
  config.port = database_config['port']
end

class Graph

  def get_node id
    database.find_node_index 'movies', 'id', id
  end

  def find_relationship nodes
    database.get_node_relationships_to(*nodes)
  end

  def create_relationship nodes
    database.create_relationship 'connection', *nodes, weight: 0
  end

  def get_weight relationship
    database.get_relationship_properties(relationship, 'weight')['weight']
  end

  def set_weight relationship, weight
    database.set_relationship_properties relationship, weight: weight
  end

  def create_unique_node movie
    index_name = 'movies'
    key = 'id'
    unique_value = movie.id
    properties = { id: movie.id, title: movie.title }
    database.create_unique_node index_name, key, unique_value, properties
  end

  private

  def database
    @_db ||= Neography::Rest.new
  end
end
