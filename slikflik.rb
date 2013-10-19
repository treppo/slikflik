require 'rubygems'
require 'sinatra/base'
require 'neography'
require 'slim'

class SlikFlik < Sinatra::Base
  get '/' do
    slim :index
  end
end
