require "neography"

class NeographyConnection
  class << self
    def db
      Neography::Rest.new(url)
    end

    private

    def url
      from_env || from_config
    end

    def from_env
      ENV["NEO4J_URL"]
    end

    def from_config
      YAML.load_file("config/database.yml")[ENV["RACK_ENV"]]["url"]
    end
  end
end
