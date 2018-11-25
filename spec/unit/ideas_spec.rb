require "spec_helper"
require "ideas"
require "interfaces/findable"

describe Ideas do
  it "fetches the movies and returns their neighbors" do
    @fetcher = Minitest::Mock.new
    @fetcher.expect :movies, ["movie1", "movie2"]
    @movie_repository = Minitest::Mock.new
    @movie_repository.expect :find_neighbors, ["neighbor1", "neighbor2"], [["movie1", "movie2"]]
    @subject = Ideas.new ids: [1, 2], fetcher: @fetcher, movie_repository: @movie_repository

    @subject.find

    @movie_repository.verify
  end
end
