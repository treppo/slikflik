require_relative '../../slikflik'
require 'minitest/assertions'
require 'capybara'
require 'capybara/dsl'
require 'capybara_minitest_spec'
require 'rack/test'
require 'multi_json'

class ApplicationRunner
  include Minitest::Assertions
  include Capybara::DSL
  include Rack::Test::Methods

  attr_accessor :assertions

  def initialize
    @assertions = 0
    Capybara.app = app
  end

  def app
    SlikFlik.new
  end

  def submit_movies movies
    VCR.use_cassette :tmdb_configuration_lookup do
      VCR.use_cassette :tmdb_lookup do
        visit '/'
        fill_in 'First Movie', with: movies[0]
        fill_in 'Second Movie', with: movies[1]
        click_on 'Get recommendations'
      end
    end
  end

  def submit_movies_with_ajax movies
    VCR.use_cassette :tmdb_configuration_lookup do
      VCR.use_cassette :tmdb_lookup do
        post '/ideas', { movies: movies }, { xhr: true }

        follow_redirect!
      end
    end
  end

  def shows_result? *properties
    properties.each { |property| page.must_have_content property }
  end

  def shows_result_without_layout? *properties
    properties.each { |property| last_response.body.must_include property.to_s }
    last_response.body.wont_include '<html>'
    last_response.body.wont_include '<body>'
  end

  def shows_result_in_order? earlier_result, later_result
    page.body.index(earlier_result).must_be :<, page.body.index(later_result)
  end

  def submit_title title
    VCR.use_cassette :tmdb_configuration_lookup do
      VCR.use_cassette :tmdb_title_search do
        visit '/'
        fill_in 'First movie title', with: title
        click_on 'Search'
      end
    end
  end

  def shows_suggestion? *properties
    properties.each { |property| page.must_have_content property }
  end

  def request_suggestions_as_json title
    VCR.use_cassette :tmdb_configuration_lookup do
      VCR.use_cassette :tmdb_title_search do
        get '/suggestions.json', title: title
      end
    end
  end

  def shows_json_suggestion? properties
    last_json_response.must_include properties
  end

  private

  def last_json_response
    MultiJson.load last_response.body, symbolize_keys: true
  end
end
