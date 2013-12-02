require 'fetcher'
require 'repository'

class Ideas
  def initialize args
    @ids = args.fetch :ids
    @movie_repository = args.fetch :movie_repository, Repository.new
    @fetcher = args.fetch :fetcher, Fetcher.new(ids: @ids, movie_repository: movie_repository)
  end

  def find
    movie_repository.find_neighbors fetcher.movies
  end

  private

  attr_reader :fetcher, :movie_repository
end
