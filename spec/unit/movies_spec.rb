require 'spec_helper'
require 'movies'

module FetcherInterfaceTest

  it 'responds to fetch' do
    @subject.must_respond_to :fetch
  end
end

class FetcherDouble
  include FetcherInterfaceTest

  def fetch
    ['movie1', 'movie2']
  end
end

describe Movies do
  include MoviesInterfaceTest

  before do
    @fetcher = FetcherDouble.new
    @db = Minitest::Mock.new
    @subject = Movies.new ids: [1, 2], fetcher: @fetcher, db: @db
  end

  it 'responds to connect' do
    @subject.must_respond_to :connect
  end

  it 'fetches movies and connects them' do
    @db.expect :connect, true, [['movie1', 'movie2']]

    @subject.connect

    @db.verify
  end
end
