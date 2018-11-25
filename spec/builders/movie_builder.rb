require "movie"

class MovieBuilder
  def initialize(args)
    @ids = args.fetch :ids, [1]
    @class = args.fetch :class, Movie
  end

  def movies
    properties.map { |props| @class.new props }
  end

  def properties
    @ids.map do |id|
      {
        id: id,
        title: "title#{id}",
        release_date: "200#{id}-1-1",
        poster_path: "poster#{id}.jpg",
      }
    end
  end
end
