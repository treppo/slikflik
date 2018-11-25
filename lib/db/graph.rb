require_relative "neography_connection"

class Graph
  def find_movies(ids)
    ids.flat_map(&find_movie)
  end

  def find_connection(movies)
    ids = movies.map { |movie| movie.fetch :id }
    response = find_relationship ids

    return {} if empty_response? response

    properties = symbolize_keys unpack_connection_properties response
    properties.merge movie_ids: ids
  end

  def connect(movies)
    ids = movies.map { |movie| movie.fetch :id }
    properties = symbolize_keys unpack_connection_properties database.execute_query "
      START a=node:movies(id = '#{ids[0]}'),
            b=node:movies(id = '#{ids[1]}')
      CREATE (a)-[r:CONNECTION { weight: 1 }]->(b)
      RETURN r
    "

    properties.merge movie_ids: ids
  end

  def update_connection(connection)
    relationship = unpack_response find_relationship connection.delete :movie_ids

    database.set_relationship_properties relationship, connection
  end

  def create(movies)
    movies.map(&create_unique_node).map(&get_node_properties)
  end

  def find_neighbors(movie_ids)
    results = movie_ids.flat_map(&get_neighbors)
    sorted_results = results.sort_by(&:last).reverse
    sorted_properties = sorted_results.map { |res| symbolize_keys res.first }
    neighbors = remove_reference_movies sorted_properties, movie_ids
    neighbors.uniq
  end

  private

  def remove_reference_movies(results, movie_ids)
    results.reject { |movie| movie_ids.include? movie[:id] }
  end

  def get_neighbors
    -> (id) do
      response = database.execute_query("
        START movie=node:movies(id = '#{id}')
        MATCH (movie)-[r:CONNECTION]-(neighbor)
        RETURN neighbor, r.weight
      ")
      connection = response.fetch("data")
      connection.map { |neighbor| [neighbor.first.fetch("data"), neighbor.last] }
    end
  end

  def find_movie
    -> (id) do
      response = database.find_node_index("movies", "id", id)
      return {} if response.nil?

      symbolize_keys unpack_response response.first
    end
  end

  def create_unique_node
    -> (movie) do
      index_name = "movies"
      key = "id"
      unique_value = movie.fetch :id
      database.create_unique_node index_name, key, unique_value, movie
    end
  end

  def find_relationship(ids)
    database.execute_query "
      START a=node:movies(id = '#{ids[0]}'),
            b=node:movies(id = '#{ids[1]}')
      MATCH (a)-[r:CONNECTION]-(b)
      RETURN r
    "
  end

  def get_node_properties
    -> (node) do
      symbolize_keys unpack_response node
    end
  end

  def symbolize_keys(hsh)
    Hash[hsh.map { |(k, v)| [k.to_sym, v] }]
  end

  def unpack_connection_properties(obj)
    unpack_response(obj).flatten.first.fetch("data")
  end

  def unpack_movie_properties(obj)
    puts unpack_response(obj)
    unpack_response(obj).map { |resp| resp.fetch "data" }
  end

  def unpack_response(obj)
    obj.fetch "data"
  end

  def empty_response?(response)
    unpack_response(response).empty?
  end

  def database
    @_db ||= NeographyConnection.db
  end
end
