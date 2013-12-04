require 'spec_helper'
require 'title_search'
require 'suggestion'
require 'ducktypes/title_searching'

describe TitleSearch do

  let(:title) { 'title' }
  let(:suggestion_list) { [Suggestion.new, Suggestion.new] }

  before do
    @encyclopedia = Quacky.mock :encyclopedia, TitleSearching
    @subject = TitleSearch.new title: title, encyclopedia: @encyclopedia
  end

  it 'responds to suggestions' do
    @subject.must_respond_to :suggestions
  end

  it 'returns suggestions from the encyclopedia' do
    @encyclopedia.stub :search_title, suggestion_list, [title]

    @subject.suggestions.must_equal suggestion_list
  end
end
