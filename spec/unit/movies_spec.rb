require 'spec_helper'
require 'movies'
require 'interfaces/fetcher'

class FetcherDouble

  def movies
    ['movie1', 'movie2']
  end
end

describe FetcherDouble do
  include FetcherInterfaceTest

  before do
    @subject = FetcherDouble.new
  end
end

describe Movies do

  before do
    @fetcher = FetcherDouble.new
    @repository = Minitest::Mock.new
    @subject = Movies.new ids: [1, 2], fetcher: @fetcher, repository: @repository
  end

  it 'responds to connect' do
    @subject.must_respond_to :connect
  end

  it 'fetches movies and connects them' do
    @repository.expect :connect, true, [['movie1', 'movie2']]

    @subject.connect

    @repository.verify
  end
end
