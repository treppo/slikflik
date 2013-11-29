require 'graph'

class Repository

  def initialize
    @graph = Graph.new
  end

  def find ids
    empty_response = { found: [], missing: [] }
    ids.zip(nodes(ids)).inject(empty_response, &divide_found_and_missing)
  end

  def create movies
    movies.map { |movie| graph.create_unique_node movie }
  end

  def connect nodes
    increase_weight relationship nodes

    relationship nodes
  end

  private

  attr_reader :graph

  def divide_found_and_missing
    ->(response, (id, node)) do
      node.nil? ? response[:missing] << id : response[:found] << node
      response
    end
  end

  def nodes ids
    ids.flat_map { |id| graph.get_node id }
  end

  def increase_weight relationship
    graph.set_weight relationship, graph.get_weight(relationship) + 1
  end

  def relationship nodes
    @_relationship ||= graph.find_relationship(nodes) || graph.create_relationship(nodes)
  end
end
