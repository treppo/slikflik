require 'test_helper'
require 'application_runner'

describe 'Slik Flik' do

  before do
    @app = ApplicationRunner.new
  end

  it 'shows a result based on a prior connection' do
    @app.submit_movies 550, 120
    # no result yet

    @app.submit_movies 550, 600
    @app.shows_result 120.to_s
  end

end
