require 'spec_helper'
require 'repository'
require 'interfaces/repository'
require 'movie'
require 'ducktypes/graph'
require 'ducktypes/neighbors_finding'

describe Repository do

  include RepositoryInterfaceTest

  let(:ids) { [1, 2] }
  let(:movie_properties) { [{ id: 1, title: 'title1' }, { id: 2, title: 'title2'}] }
  let(:movies) { [
    Movie.new(id: 1, title: 'title1'),
    Movie.new(id: 2, title: 'title2')
  ] }

  let(:connection) {{ movie_ids: ids, weight: 1 }}
  let(:no_connection) { {} }

  before do
    @graph = Quacky.mock :graph, GraphDucktype
    @subject = Repository.new graph: @graph
  end

  it { assert_quacks_like @subject, NeighborsFinding }

  it 'creates movies in the database and returns them' do
    @graph.stub :create, movies

    @subject.create(movies).must_equal movies
  end

  context 'when searching for a movie' do
    it 'returns the ids of the missing movies' do
      @graph.stub :find_movies, [{}, {}]
      @subject.find(ids).must_equal({
        found: [],
        missing: ids
      })
    end

    it 'returns the found movies' do
      @graph.stub :find_movies, movie_properties

      @subject.find(ids).must_equal({
        found: movies,
        missing: []
      })
    end
  end

  context 'there is no prior connection between two movies' do
    before do
      @graph = Minitest::Mock.new
      @subject = Repository.new graph: @graph
    end

    it 'connects the movies' do
      @graph.expect :find_connection, no_connection, [movie_properties]
      @graph.expect :connect, connection, [movie_properties]

      @subject.connect movies

      @graph.verify
    end
  end

  context 'there is a connection already' do
    before do
      @graph = Minitest::Mock.new
      @subject = Repository.new graph: @graph
    end

    it 'increases the connections weight' do
      @graph.expect :find_connection, connection, [movie_properties]
      @graph.expect :update_connection, nil, [{movie_ids: ids, weight: 2}]

      @subject.connect movies

      @graph.verify
    end
  end

  it 'finds neighboring movies and returns them' do
    neighbors_properties = [{ id: 0, title: 'title0' }, { id: 3, title: 'title3' }]
    neighbors = neighbors_properties.map { |prop| Movie.new prop }
    @graph.stub :find_neighbors, neighbors_properties, [ids]

    @subject.find_neighbors(movies).must_equal neighbors
  end
end
