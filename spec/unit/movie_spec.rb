require 'spec_helper'
require 'movie'

describe Movie do

  def properties(release_date)
    {
        id: 1,
        title: 'title',
        release_date: release_date,
        poster_path: 'poster/path.jpg'
    }
  end

  it 'can be turned to a hash of properties' do
    @subject = Movie.new properties('2012-01-31')
    @subject.to_h.must_equal properties('2012-01-31')
  end

  it 'returns a year' do
    @subject = Movie.new properties('2012-01-31')
    @subject.year.must_equal 2012
  end

  context 'the release_date is empty' do
    it 'returns an empty year' do
      @subject = Movie.new properties('')
      @subject.year.must_equal ''
    end
  end
end
