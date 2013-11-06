require 'rubygems'
require 'sinatra/base'
require 'neography'
require 'slim'

require 'movies'
require 'ideas'

class SlikFlik < Sinatra::Base
  get '/' do
    slim :index
  end

  post '/ideas' do
    Movies.connect params[:movies]
  end
end
