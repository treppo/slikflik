require 'spec_helper'
require 'repository'
require 'interfaces/repository'
require 'test_database_connection'
require 'movie'

describe Repository do

  include RepositoryInterfaceTest

  let(:ids) { [1, 2] }

  let(:movies) { [
    Movie.new(id: 1, title: 'title1'),
    Movie.new(id: 2, title: 'title2')
  ] }

  def database
    @_database ||= TestDatabaseConnection.new
  end

  before do
    database.reset
    @subject = Repository.new
  end

  it 'creates movie nodes in the database and returns them' do
    nodes = @subject.create movies

    nodes.length.must_equal 2
    database.node_count.must_equal 2
  end

  it 'creates unique nodes' do
    @subject.create movies
    @subject.create movies

    database.node_count.must_equal 2
  end

  it 'creates movie nodes with an id and a title property' do
    node_1, node_2 = @subject.create movies

    database.get_node_property(node_1, 'id').must_equal 1
    database.get_node_property(node_1, 'title').must_equal 'title1'
    database.get_node_property(node_2, 'id').must_equal 2
    database.get_node_property(node_2, 'title').must_equal 'title2'
  end

  context 'when searching for a movie' do
    it 'returns the ids of the missing movies' do
      @subject.find(ids).must_equal({
        found: [],
        missing: ids
      })
    end

    it 'returns the found nodes' do
      nodes = @subject.create movies

      @subject.find(ids).must_equal({
        found: nodes,
        missing: []
      })
    end
  end

  context 'there is no prior connection between two nodes' do
    it 'connects the nodes' do
      nodes = @subject.create movies

      @subject.connect nodes

      database.relationship_count.must_equal 1
    end

    it 'creates unique connections' do
      nodes = @subject.create movies

      @subject.connect nodes
      @subject.connect nodes

      database.relationship_count.must_equal 1
    end

    it 'sets the weight to 1' do
      nodes = @subject.create movies

      relationship = @subject.connect nodes

      database.get_relationship_property(relationship, 'weight').must_equal 1
    end
  end

  context 'there is a connection already' do
    it 'increases the weight of the connection' do
      nodes = @subject.create movies

      @subject.connect nodes
      relationship = @subject.connect nodes

      database.get_relationship_property(relationship, 'weight').must_equal 2
    end
  end
end
