require "graph"

class Repository
  def initialize(args = {})
    @graph = args.fetch :graph, Graph.new
  end

  def find(ids)
    empty_response = {found: [], missing: []}
    ids.zip(get_nodes(ids)).inject(empty_response, &divide_found_and_missing)
  end

  def create(movies)
    # TODO call properties instead of to_h
    properties_to_movies graph.create movies.map(&:to_h)
  end

  def connect(movies)
    response = graph.find_connection movies.map(&:to_h)

    if response.empty?
      graph.connect movies.map(&:to_h)
    else
      response[:weight] += 1
      graph.update_connection response
    end
  end

  def find_neighbors(movies)
    properties_to_movies graph.find_neighbors(movies.map(&:id))
  end

  private

  attr_reader :graph

  def properties_to_movies(props)
    props.map { |properties| Movie.new properties }
  end

  def divide_found_and_missing
    -> (response, (id, properties)) do
      if properties.empty?
        response[:missing] << id
      else
        response[:found] << Movie.new(properties)
      end
      response
    end
  end

  def get_nodes(ids)
    graph.find_movies ids
  end
end
