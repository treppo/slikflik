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
    visit '/'
    fill_in 'First Movie', with: movies[0]
    fill_in 'Second Movie', with: movies[1]
    click_on 'Find'
  end

  def shows_result? id, title
    page.must_have_content id.to_s
    page.must_have_content title.to_s
  end
end
