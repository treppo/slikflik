require 'spec_helper'
require 'encyclopedia'
require 'interfaces/encyclopedia'
require 'ducktypes/title_searching'

describe Encyclopedia do

  include EncyclopediaInterfaceTest

  let(:ids) { [938, 335] }
  let(:id) { [938] }
  let(:whitelist) { [:id, :title] }
  let(:filtered_property) { :original_title }
  let(:title) { 'once upon a time in the west' }

  before do
    @subject = Encyclopedia.new property_whitelist: whitelist
  end

  it 'behaves like a title searcher' do
    assert_quacks_like @subject, TitleSearching
  end

  it 'looks up entries in the external movie database' do
    VCR.use_cassette 'tmdb_lookup' do
      entries = @subject.entries(ids)

      entries[0].title.must_equal 'For a Few Dollars More'
      entries[1].title.must_equal 'Once Upon a Time in the West'
    end
  end

  it 'filters movie properties according to the whitelist' do
    VCR.use_cassette 'tmdb_lookup' do
      entries = @subject.entries(id)

      entries[0].must_respond_to :title
      entries[0].must_respond_to :id
      entries[0].wont_respond_to filtered_property
    end
  end

  it 'searches for titles' do
    VCR.use_cassette :tmdb_title_search do
      suggestions = @subject.search_title title

      suggestions[0].title.must_equal 'Once Upon a Time in the West'
      suggestions[0].id.must_equal 335
    end
  end
end
