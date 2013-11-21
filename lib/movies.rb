class Movies

  def initialize args
    @ids = args.fetch :ids
    @repository = args.fetch :repository || DatabaseConnection.new(@ids)
    @fetcher = args.fetch :fetcher || MoviesFetcher.new(repository: @repository)
  end

  def connect
    repository.connect fetcher.movies
  end

  private

  attr_reader :fetcher, :repository
end
