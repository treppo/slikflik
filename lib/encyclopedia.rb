require 'faraday'
require 'multi_json'
require 'suggestion'
require 'movie'

class Encyclopedia

  DEFAULT_WHITELIST = [:title, :id]

  def initialize args = {}
    @whitelist = args.fetch :property_whitelist, DEFAULT_WHITELIST
  end

  def entries ids
    ids.map do |id|
      Movie.new filtered_properties parse movie_retrieval_request id
    end
  end

  def search_title title
    parse(title_search_request title).fetch(:results).map do |result|
      Suggestion.new result
    end
  end

  private

  attr_reader :whitelist

  def filtered_properties props
    props.reject(&filter)
  end

  def filter
    ->(key, value) do
      ! whitelist.include? key
    end
  end

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
