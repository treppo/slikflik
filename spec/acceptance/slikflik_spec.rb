require 'spec_helper'
require_relative 'application_runner'

describe 'Slik Flik' do

  before do
    @app = ApplicationRunner.new
  end

  it 'shows a result based on a prior connection' do
    @app.submit_movies [930, 335]
    # no result yet

    @app.submit_movies [335, 391]
    @app.shows_result? 930, 'A Fistful of Dollars'
  end
end
