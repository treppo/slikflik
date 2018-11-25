require "spec_helper"
require "title_search"
require "suggestion"
require "builders/movie_builder"

describe TitleSearch do
  title = "title"
  suggestion_list = MovieBuilder.new(ids: [1, 2], class: Suggestion).movies

  before do
    @encyclopedia = MiniTest::Mock.new
    @subject = TitleSearch.new title: title, encyclopedia: @encyclopedia
  end

  it "responds to suggestions" do
    @subject.must_respond_to :suggestions
  end

  it "returns suggestions from the encyclopedia" do
    @encyclopedia.expect :search_title, suggestion_list, [title]

    @subject.suggestions.must_equal suggestion_list

    @encyclopedia.verify
  end
end
