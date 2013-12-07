require 'spec_helper'
require 'movie'

describe Movie do

  let(:release_date) { '2012-01-31' }

  let(:properties) {{
    id: 1,
    title: 'title',
    release_date: release_date,
    poster_path: 'poster/path.jpg'
  }}

  before do
    @subject = Movie.new properties
  end

  it 'can be turned to a hash of properties' do
    @subject.to_h.must_equal properties
  end

  it 'returns a year' do
    @subject.year.must_equal 2012
  end

  context 'the release_date is empty' do
    let(:release_date) { '' }

    it 'returns an empty year' do
      @subject.year.must_equal ''
    end
  end
end
