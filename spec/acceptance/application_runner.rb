require_relative '../../slikflik'
require 'minitest/assertions'

require 'capybara'
require 'capybara/dsl'
require 'capybara_minitest_spec'

class ApplicationRunner
  include Minitest::Assertions
  include Capybara::DSL

  Capybara.app = SlikFlik.new

  attr_accessor :assertions

  def initialize
    @assertions = 0
  end

  def submit_movies movies
    VCR.use_cassette :tmdb_configuration_lookup do
      VCR.use_cassette :tmdb_lookup do
        visit '/'
        fill_in 'First Movie', with: movies[0]
        fill_in 'Second Movie', with: movies[1]
        click_on 'Find'
      end
    end
  end

  def shows_result? *properties
    properties.each { |property| page.must_have_content property }
  end

  def submit_title title
    VCR.use_cassette :tmdb_configuration_lookup do
      VCR.use_cassette :tmdb_title_search do
        visit '/'
        fill_in 'First title', with: title
        click_on 'Search'
      end
    end
  end

  def shows_suggestion? *properties
    properties.each { |property| page.must_have_content property }
  end
end
