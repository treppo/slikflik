require_relative '../slikflik'
require 'minitest/assertions'
require 'rack/test'

class ApplicationRunner
  include Minitest::Assertions
  include Rack::Test::Methods

  attr_accessor :assertions

  def initialize
    @assertions = 0
  end

  def app
    SlikFlik
  end

  def submit_movies movie_1, movie_2
    post '/link', from: movie_1, to: movie_2
  end

  def shows_result movie
    assert_includes last_response.body, movie
  end
end
