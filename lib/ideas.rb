require 'fetcher'
require 'neighbors'

class Ideas
  def initialize args
    @ids = args.fetch :ids
    @fetcher = args.fetch :fetcher, Fetcher.new(ids: @ids)
    @neighbors = args.fetch :neighbors, Neighbors.new
  end

  def find
    neighbors.find fetcher.movies
  end

  private

  attr_reader :fetcher, :neighbors
end
