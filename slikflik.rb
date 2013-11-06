require 'rubygems'
require 'sinatra/base'
require 'neography'
require 'slim'

require 'movies'

class SlikFlik < Sinatra::Base
  get '/' do
    slim :landing
  end

  post '/ideas' do
    redirect to "/ideas?movies[]=#{params[:movies][0]}&movies[]=#{params[:movies][1]}"
  end

  get '/ideas' do
    slim :index, locals: { ideas: [] }
  end
end
