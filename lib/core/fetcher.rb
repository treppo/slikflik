require_relative "lookup"
require_relative "repository"

class Fetcher
  def initialize(args)
    @repository = args.fetch :repository, Repository.new
    @ids = args.fetch :ids
    @lookup = args.fetch :lookup_class, Lookup
  end

  def movies
    found + looked_up
  end

  private

  attr_reader :repository, :lookup, :ids

  def found
    response.fetch :found
  end

  def missing
    response.fetch :missing
  end

  def looked_up
    missing.empty? ? [] : lookup.new(ids: missing).entries
  end

  def response
    @_response ||= repository.find ids
  end
end
