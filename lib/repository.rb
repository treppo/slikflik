require 'graph'

class Repository

  def initialize args = {}
    @graph = args.fetch :graph, Graph.new
  end

  def find ids
    empty_response = { found: [], missing: [] }
    ids.zip(get_nodes(ids)).inject(empty_response, &divide_found_and_missing)
  end

  def create movies
    graph.add movies.map(&:to_h)
  end

  def connect nodes
    graph.increase_weight connection nodes
  end

  private

  attr_reader :graph

  def divide_found_and_missing
    ->(response, (id, node)) do
      node.nil? ? response[:missing] << id : response[:found] << node
      response
    end
  end

  def get_nodes ids
    graph.get_nodes ids
  end

  def connection nodes
    @_connection ||= graph.get_connection(nodes) || graph.connect(nodes)
  end
end
