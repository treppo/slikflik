require 'neography'

database_config = YAML.load_file('config/database.yml')['development']

Neography.configure do |config|
  config.server = database_config['server']
  config.port = database_config['port']
end

class Repository

  def find ids
    empty_response = { found: [], missing: [] }
    ids.zip(nodes(ids)).inject(empty_response, &divide_found_and_missing)
  end

  def create movies
    movies.map { |movie| create_unique_node movie }
  end

  def connect nodes
    increase_weight relationship nodes

    relationship nodes
  end

  private

  def divide_found_and_missing
    ->(response, (id, node)) do
      node.nil? ? response[:missing] << id : response[:found] << node
      response
    end
  end

  def nodes ids
    ids.flat_map { |id| database.find_node_index 'movies', 'id', id }
  end

  def increase_weight relationship
    set_weight relationship, get_weight(relationship) + 1
  end

  def relationship nodes
    @_relationship ||= find_relationship(nodes) || create_relationship(nodes)
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

  def database
    @_db ||= Neography::Rest.new
  end

  def create_unique_node movie
    index_name = 'movies'
    key = 'id'
    unique_value = movie.id
    properties = { id: movie.id, title: movie.title }
    database.create_unique_node index_name, key, unique_value, properties
  end
end
