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

  it 'shows a result based on a prior connection' do
    @app.submit_movies [938, 335]
    @app.submit_movies [391, 429]

    @app.submit_movies [335, 391]
    @app.shows_result? 'For a Few Dollars More'
    @app.shows_result? 'The Good, the Bad and the Ugly'
  end
end
