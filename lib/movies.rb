require 'neography'

database_config = YAML.load_file('config/database.yml')['development']

Neography.configure do |config|
  config.server = database_config['server']
  config.port = database_config['port']
end


class Movies
  class << self
    def create movie_ids
      movie_ids.map { |id| create_unique_node id }
    end

    private

    def database
      @_db ||= Neography::Rest.new
    end

    def create_unique_node movie_id
      index_name = 'movies'
      key = 'id'
      unique_value = movie_id
      database.create_unique_node index_name, key, unique_value
    end
  end
end
