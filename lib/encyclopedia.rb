require 'faraday'
require 'multi_json'

require 'movie'

class Encyclopedia

  def entries ids
    ids.map do |id|
      Movie.new get id
    end
  end

  private

  def get id
    # TODO only allow needed fields
    MultiJson.load connection.get("#{id}", api_key: ENV['TMDB_API_KEY']).body
  end

  def connection
    @_connection ||= Faraday.new url: "https://api.themoviedb.org/3/movie/"
  end
end
