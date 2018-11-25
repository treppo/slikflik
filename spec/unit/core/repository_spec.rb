require "spec_helper"
require "core/repository"
require "interfaces/repository"
require "builders/movie_builder"

describe Repository do
  include RepositoryInterfaceTest

  let(:ids) { [1, 2] }
  let(:movie_properties) { MovieBuilder.new(ids: ids).properties }
  let(:movies) { MovieBuilder.new(ids: ids).movies }

  let(:neighbors_properties) { MovieBuilder.new(ids: [0, 3]).properties }
  let(:neighbors) { MovieBuilder.new(ids: [0, 3]).movies }

  let(:connection) { {movie_ids: ids, weight: 1} }
  let(:no_connection) { {} }

  before do
    @graph = Minitest::Mock.new
    @subject = Repository.new graph: @graph
  end

  it "creates movies in the database and returns them" do
    @graph.expect :create, movie_properties, [movies.map(&:to_h)]

    @subject.create(movies).must_equal movies

    @graph.verify
  end

  context "when searching for a movie" do
    it "returns the ids of the missing movies" do
      @graph.expect :find_movies, [{}, {}], [ids]

      @subject.find(ids).must_equal({
        found: [],
        missing: ids,
      })

      @graph.verify
    end

    it "returns the found movies" do
      @graph.expect :find_movies, movie_properties, [ids]

      @subject.find(ids).must_equal({
        found: movies,
        missing: [],
      })

      @graph.verify
    end
  end

  context "there is no prior connection between two movies" do
    before do
      @graph = Minitest::Mock.new
      @subject = Repository.new graph: @graph
    end

    it "connects the movies" do
      @graph.expect :find_connection, no_connection, [movie_properties]
      @graph.expect :connect, connection, [movie_properties]

      @subject.connect movies

      @graph.verify
    end
  end

  context "there is a connection already" do
    before do
      @graph = Minitest::Mock.new
      @subject = Repository.new graph: @graph
    end

    it "increases the connections weight" do
      @graph.expect :find_connection, connection, [movie_properties]
      @graph.expect :update_connection, nil, [{movie_ids: ids, weight: 2}]

      @subject.connect movies

      @graph.verify
    end
  end

  it "finds neighboring movies and returns them" do
    @graph.expect :find_neighbors, neighbors_properties, [ids]

    @subject.find_neighbors(movies).must_equal neighbors
  end
end
