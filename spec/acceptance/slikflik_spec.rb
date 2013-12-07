require 'spec_helper'
require_relative 'application_runner'
require 'test_database_connection'

describe 'Slik Flik' do

  before do
    @app = ApplicationRunner.new
  end

  after do
    TestDatabaseConnection.new.reset
  end

  it 'shows a result based on connections' do
    @app.submit_movies [938, 335]
    @app.submit_movies [391, 429]

    @app.submit_movies [335, 391]
    @app.shows_result? 'For a Few Dollars More', 1965
    @app.shows_result? 'The Good, the Bad and the Ugly', 1966
  end

  it 'shows title suggestions' do
    @app.submit_title 'oldboy'
    @app.shows_suggestion? 87516, 'Oldboy', 2013
    @app.shows_suggestion? 670, 'Oldboy', 2003
  end

  it 'returns title suggestions as json' do
    @app.request_suggestions_as_json 'oldboy'
    @app.shows_json_suggestion? id: 87516,
      title: 'Oldboy (2013)',
      poster: 'http://d3gtl9l2a4fn1j.cloudfront.net/t/p/w92/e8RaZIeFeHpPolSqKGsFVzZRiaE.jpg'

    @app.shows_json_suggestion? id: 670,
      title: 'Oldboy (2003)',
      poster: 'http://d3gtl9l2a4fn1j.cloudfront.net/t/p/w92/fct7n9V10E8t8a7wOR90Ccw0i48.jpg'
  end
end
