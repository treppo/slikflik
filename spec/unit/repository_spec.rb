require 'spec_helper'
require 'repository'
require 'interfaces/repository'
require 'movie'
require 'ducktypes/graph'

describe Repository do

  include RepositoryInterfaceTest

  let(:ids) { [1, 2] }

  let(:movies) { [
    Movie.new(id: 1, title: 'title1'),
    Movie.new(id: 2, title: 'title2')
  ] }

  before do
    @graph = Quacky.mock :graph, GraphDucktype
    @subject = Repository.new graph: @graph
  end

  it 'creates movie nodes in the database and returns them' do
    expected = ['node1', 'node2']
    @graph.stub :add, expected

    @subject.create(movies).must_equal expected
  end

  context 'when searching for a movie' do
    it 'returns the ids of the missing movies' do
      @graph.stub :get_nodes, [nil, nil]
      @subject.find(ids).must_equal({
        found: [],
        missing: ids
      })
    end

    it 'returns the found nodes' do
      expected = ['node1', 'node2']
      @graph.stub :get_nodes, expected

      @subject.find(ids).must_equal({
        found: expected,
        missing: []
      })
    end
  end

  context 'there is no prior connection between two nodes' do
    it 'connects the nodes' do
      nodes = ['node1', 'node2']

      @graph.expect :connect, 'connection', [nodes]

      @subject.connect nodes
    end
  end

  context 'there is a connection already' do
    it 'gets the connection' do
      nodes = ['node1', 'node2']

      @graph.expect :get_connection, 'connection', [nodes]

      @subject.connect nodes
    end
  end

  it 'increases the connections weight' do
    nodes = ['node1', 'node2']
    @graph.stub :connect, 'connection', [nodes]

    @graph.expect :increase_weight, nil, ['connection']

    @subject.connect nodes
  end
end
