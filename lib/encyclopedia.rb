require 'faraday'
require 'multi_json'
require 'suggestion'
require 'movie'
require 'poster_url'

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

  def poster_url
    image_config = parse(configuration_request).fetch :images
    base_url = image_config.fetch(:base_url)
    PosterURL.new small: base_url + image_config.fetch(:poster_sizes).fetch(0),
      large: base_url + image_config.fetch(:poster_sizes).fetch(1)
  end

  private

  def parse response
    MultiJson.load response, symbolize_keys: true
  end

  def movie_retrieval_request id
    connection.get("movie/#{id}", api_key: ENV['TMDB_API_KEY']).body
  end

  def title_search_request title
    connection.get("search/movie", query: title, api_key: ENV['TMDB_API_KEY']).body
  end

  def configuration_request
    connection.get('configuration', api_key: ENV['TMDB_API_KEY']).body
  end

  def connection
    @_connection ||= Faraday.new url: "https://api.themoviedb.org/3/"
  end
end
