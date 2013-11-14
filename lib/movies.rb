class Movies

  def initialize args
    @ids = args.fetch :ids
    @db = args.fetch :db || DatabaseConnection.new
    @fetcher = args.fetch :fetcher || Fetcher.new(ids: @ids, db: @db)
  end

  def connect
    db.connect fetcher.fetch
  end

  private

  attr_reader :fetcher, :db
end
