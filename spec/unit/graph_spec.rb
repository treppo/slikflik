require 'spec_helper'
require 'graph'
require 'test_database_connection'

describe Graph do

  let(:ids) { [1, 2] }
  let(:movies) { [
    { id: 1, title: 'title1' },
    { id: 2, title: 'title2' }
  ] }

  let(:more_movies) { [
    { id: 0, title: 'title0' },
    { id: 1, title: 'title1' },
    { id: 2, title: 'title2' },
    { id: 3, title: 'title3' },
    { id: 4, title: 'title4' },
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

  describe 'creating and retrieving movies' do

    it 'returns the movie properties upon creation' do
      properties = @subject.create movies

      properties.must_equal movies
    end

    it 'creates unique movies' do
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
      connection[:weight] = 2

      @subject.update_connection connection

      @subject.find_connection(movies).must_equal({ movie_ids: ids, weight: 2 })
    end
  end

  describe 'finding neighbors' do
    before do
      @subject.create more_movies
      @subject.connect [more_movies[1], more_movies[2]]

      connection0 = @subject.connect [more_movies[0], more_movies[1]]
      connection0[:weight] = 2
      @subject.update_connection connection0

      connection1 = @subject.connect [more_movies[2], more_movies[3]]
      connection1[:weight] = 3
      @subject.update_connection connection1

      connection2 = @subject.connect [more_movies[2], more_movies[4]]
      connection2[:weight] = 4
      @subject.update_connection connection2

      @subject.connect [more_movies[2], more_movies[0]]
    end

    it 'returns neighboring movies' do
      results = @subject.find_neighbors ids

      results.must_include more_movies[0]
      results.must_include more_movies[3]
      results.must_include more_movies[4]
    end

    it 'only returns the neighbors' do
      @subject.find_neighbors(ids).length.must_equal 3
    end

    it 'returns the movies in descending order of their connection weight' do
      results = @subject.find_neighbors ids

      results.index(more_movies[0]).must_be :>, results.index(more_movies[3])
      results.index(more_movies[3]).must_be :>, results.index(more_movies[4])
    end
  end
end
