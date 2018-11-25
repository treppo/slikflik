require "spec_helper"
require "core/movies"
require "doubles/fetcher"
require "interfaces/connectable"

describe Movies do
  before do
    @fetcher = FetcherDouble.new
    @repository = Minitest::Mock.new
    @subject = Movies.new ids: [1, 2], fetcher: @fetcher, repository: @repository
  end

  it "fetches movies and connects them" do
    @repository.expect :connect, true, [["movie1", "movie2"]]

    @subject.connect

    @repository.verify
  end
end
