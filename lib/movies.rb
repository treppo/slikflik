require 'fetcher'
require 'repository'

class Movies

  def initialize args
    @ids = args.fetch :ids
    @repository = args.fetch :repository, Repository.new(@ids)
    @fetcher = args.fetch :fetcher, Fetcher.new(repository: @repository)
  end

  def connect
    repository.connect fetcher.movies
  end

  private

  attr_reader :fetcher, :repository
end
