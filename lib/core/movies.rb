require_relative "fetcher"
require_relative "repository"

class Movies
  def initialize(args)
    @ids = args.fetch :ids
    @repository = args.fetch :repository, Repository.new
    @fetcher = args.fetch :fetcher, Fetcher.new(repository: @repository, ids: @ids)
  end

  def connect
    repository.connect fetcher.movies
  end

  private

  attr_reader :fetcher, :repository
end
