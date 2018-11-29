require "spec_helper"
require "core/movie"

describe Movie do
  properties =
    {
      id: 1,
      title: "title",
      release_date: "2012-01-31",
      poster_path: "poster/path.jpg",
    }

  it "can be turned to a hash of properties" do
    @subject = Movie.new properties
    @subject.to_h.must_equal properties
  end

  it "returns a year" do
    @subject = Movie.new properties
    @subject.year.must_equal 2012
  end

  context "the release_date is empty" do
    it "returns an empty year" do
      @subject = Movie.new properties.merge(release_date: "")
      @subject.year.must_equal ""
    end
  end

  it "handles missing properties" do
    Movie.new(properties.merge(poster_path: nil)).poster_path.must_equal("")
  end
end
