require 'faraday'
require 'multi_json'

require 'movie'

class Encyclopedia

  DEFAULT_WHITELIST = [:title, :id]

  def initialize args = {}
    @whitelist = args.fetch :property_whitelist, DEFAULT_WHITELIST
  end

  def entries ids
    ids.map do |id|
      Movie.new filtered_properties id
    end
  end

  private

  attr_reader :whitelist

  def filtered_properties id
    properties(id).reject(&filter)
  end

  def filter
    ->(key, value) do
      ! whitelist.include? key
    end
  end

  def properties id
    MultiJson.load request(id), symbolize_keys: true
  end

  def request id
    connection.get("#{id}", api_key: ENV['TMDB_API_KEY']).body
  end

  def connection
    @_connection ||= Faraday.new url: "https://api.themoviedb.org/3/movie/"
  end
end
