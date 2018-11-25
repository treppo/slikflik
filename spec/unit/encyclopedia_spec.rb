require "spec_helper"
require "encyclopedia"
require "interfaces/encyclopedia"

describe Encyclopedia do
  include EncyclopediaInterfaceTest

  before do
    @subject = Encyclopedia.new
  end

  it "looks up entries in the external movie database" do
    VCR.use_cassette :tmdb_lookup do
      entries = @subject.entries([938, 335])

      entries[0].title.must_equal "For a Few Dollars More"
      entries[1].title.must_equal "Once Upon a Time in the West"
    end
  end

  it "searches for titles" do
    VCR.use_cassette :tmdb_title_search do
      suggestions = @subject.search_title "once upon a time in the west"

      suggestions[0].title.must_equal "Once Upon a Time in the West"
      suggestions[0].id.must_equal 335
    end
  end

  it "returns the poster url" do
    VCR.use_cassette :tmdb_configuration_lookup do
      poster_url = @subject.poster_url

      poster_url.small.must_match /^http:\/\/.*\/w92$/
      poster_url.large.must_match /^http:\/\/.*\/w154$/
    end
  end
end
