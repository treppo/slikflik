require 'spec_helper'
require_relative 'application_runner'

describe 'Slik Flik' do

  before do
    @app = ApplicationRunner.new
  end

  it 'shows a result based on a prior connection' do
    @app.submit_movies [938, 335]
    # no result yet

    @app.submit_movies [335, 391]
    @app.shows_result? 938, 'Per qualche dollaro in più'
  end
end
