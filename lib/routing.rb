require "rubygems"
require "sinatra/base"
require "tilt/jbuilder"
require "sinatra/jbuilder"
require "slim"

require_relative "core/movies"
require_relative "core/ideas"
require_relative "core/title_search"

class Routing < Sinatra::Base
  set :poster_url, Proc.new { Encyclopedia.new.poster_url }

  get "/" do
    slim :landing
  end

  post "/ideas" do
    Movies.new(ids: submitted_movies).connect
    path = "/ideas?movies[]=#{params[:movies][0]}&movies[]=#{params[:movies][1]}"
    path += "&xhr=1" if request.xhr?

    redirect to path
  end

  get "/ideas" do
    slim :index, locals: {
                   ideas: Ideas.new(ids: submitted_movies).find,
                   poster_url: settings.poster_url,
                 }, layout: (params["xhr"] != "1")
  end

  post "/suggestions" do
    slim :suggestions, locals: {
                         suggestions: TitleSearch.new(title: params[:title]).suggestions,
                         poster_url: settings.poster_url,
                       }
  end

  get "/suggestions.json" do
    jbuilder :suggestions, locals: {
                             suggestions: TitleSearch.new(title: params[:title]).suggestions,
                             poster_url: settings.poster_url,
                           }
  end

  private

  def submitted_movies
    params[:movies]
  end
end
