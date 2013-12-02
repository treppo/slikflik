require 'spec_helper'
require 'ideas'
require 'interfaces/findable'
require 'ducktypes/neighbors_finding'
require 'ducktypes/movie_fetching'

describe Ideas do

  before do
    @fetcher = Quacky.double :fetcher, MovieFetching
    @movie_repository = Quacky.double :movie_repository, NeighborsFinding
    @subject = Ideas.new ids: [1, 2], fetcher: @fetcher, movie_repository: @movie_repository
  end

  it 'is findable' do
    assert_quacks_like @subject, Findable
  end

  it 'fetches the movies and returns their neighbors' do
    fetched_movies = ['movie1', 'movie2']
    @fetcher.stub :movies, fetched_movies

    @movie_repository.expect :find_neighbors, ['neighbor1', 'neighbor2'], [fetched_movies]

    @subject.find
  end
end
