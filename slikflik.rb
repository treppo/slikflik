require 'rubygems'
require 'sinatra/base'
require 'neography'
require 'slim'

require 'movies'
require 'ideas'
require 'title_search'

class SlikFlik < Sinatra::Base
  set :poster_url, Proc.new { Encyclopedia.new.poster_url }

  get '/' do
    slim :landing
  end

  post '/ideas' do
    Movies.new(ids: submitted_movies).connect
    redirect to "/ideas?movies[]=#{params[:movies][0]}&movies[]=#{params[:movies][1]}"
  end

  get '/ideas' do
    slim :index, locals: {
      ideas: Ideas.new(ids: submitted_movies).find,
      poster_url: settings.poster_url
    }
  end

  post '/suggestions' do
    slim :suggestions, locals: {
      suggestions: TitleSearch.new(title: params[:title]).suggestions,
      poster_url: settings.poster_url
    }
  end

  private

  def submitted_movies
    params[:movies]
  end
end
