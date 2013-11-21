class MovieFetcher

  def initialize args
    @repository = args.fetch :repository
    @lookup = args.fetch :lookup_class
  end

  def movies
    found + looked_up
  end

  private

  attr_reader :repository, :lookup

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
    @_response ||= repository.find
  end
end
