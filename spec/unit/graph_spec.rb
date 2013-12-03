require 'spec_helper'
require 'graph'
require 'test_database_connection'
require 'ducktypes/graph'

describe Graph do

  let(:ids) { [1, 2] }
  let(:movies) { [
    { id: 1, title: 'title1' },
    { id: 2, title: 'title2' }
  ] }

  def database
    @_database ||= TestDatabaseConnection.new
  end

  before do
    @subject = Graph.new
  end

  after do
    database.reset
  end

  it 'behaves like a graph type' do
    assert_quacks_like @subject, GraphDucktype
  end

  describe 'creating and retrieving movies' do

    it 'returns the movie properties upon creation' do
      properties = @subject.create movies

      properties.must_equal movies
    end

    it 'creates unique nodes' do
      @subject.create movies
      @subject.create movies

      @subject.find_movies(ids).must_equal movies
    end

    it 'finds movies' do
      @subject.create movies

      @subject.find_movies(ids).must_equal movies
    end

    it 'returns an empty hash when a node does not exist' do
      @subject.find_movies(ids).must_equal [{}, {}]
    end
  end

  describe 'connections' do

    before do
      @subject.create movies
    end

    it 'returns the connection properties' do
      properties = @subject.connect movies

      properties.must_equal({ movie_ids: ids, weight: 1 })
    end

    it 'finds the connection and return its properties' do
      @subject.connect movies

      properties = @subject.find_connection movies

      properties.must_equal({ movie_ids: ids, weight: 1 })
    end

    it 'returns an empty hash when a connection does not exist' do
      @subject.find_connection(movies).must_be_empty
    end

    it 'increases the weight of the connection' do
      connection = @subject.connect movies
      connection[:weight] = 1

      @subject.update_connection connection

      @subject.find_connection(movies).must_equal({ movie_ids: ids, weight: 1 })
    end
  end

  def create_graph nodes
    @subject.connect [nodes[0], nodes[1]]
    @subject.connect [nodes[1], nodes[2]]
    @subject.connect [nodes[2], nodes[3]]
    @subject.connect [nodes[2], nodes[4]]
    @subject.connect [nodes[2], nodes[0]]
  end

  it 'finds neighboring movies' do
    nodes = @subject.create [{id: 0}, {id: 1}, {id: 2}, {id: 3}, {id: 4}]
    create_graph nodes

    results = @subject.find_neighbors ids

    results.must_include 0
    results.must_include 3
    results.must_include 4
  end

  it 'only finds the neighbors' do
    nodes = @subject.create [{id: 0}, {id: 1}, {id: 2}, {id: 3}, {id: 4}]
    create_graph nodes

    @subject.find_neighbors(ids).length.must_equal 3
  end
end
