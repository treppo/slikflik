require 'spec_helper'
require 'encyclopedia'
require 'interfaces/encyclopedia'

describe Encyclopedia do

  include EncyclopediaInterfaceTest

  let(:ids) { [938, 335]}

  before do
    @subject = Encyclopedia.new
  end

  it 'looks up entries in the external movie database' do
    VCR.use_cassette 'tmdb_lookup' do
      @subject.entries(ids)[0].title.must_equal 'For a Few Dollars More'
      @subject.entries(ids)[1].title.must_equal 'Once Upon a Time in the West'
    end
  end
end
