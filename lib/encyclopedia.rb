require 'faraday'
require 'multi_json'
require 'suggestion'
require 'movie'

class Encyclopedia

  def entries ids
    ids.map do |id|
      Movie.new parse movie_retrieval_request id
    end
  end

  def search_title title
    parse(title_search_request title).fetch(:results).map do |result|
      Suggestion.new result
    end
  end

  private

  attr_reader :whitelist

  def parse response
    MultiJson.load response, symbolize_keys: true
  end

  def movie_retrieval_request id
    connection.get("movie/#{id}", api_key: ENV['TMDB_API_KEY']).body
  end

  def title_search_request title
    connection.get("search/movie?query=#{title}", api_key: ENV['TMDB_API_KEY']).body
  end

  def connection
    @_connection ||= Faraday.new url: "https://api.themoviedb.org/3/"
  end
end
