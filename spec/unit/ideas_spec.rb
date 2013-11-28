require 'spec_helper'
require 'ideas'
require 'interfaces/findable'
require 'doubles/fetcher'
require 'doubles/neighbors'

describe Ideas do

  include FindableInterfaceTest

  before do
    @fetcher = FetcherDouble.new
    @neighbors = NeighborsDouble.new
    @subject = Ideas.new ids: [1, 2], fetcher: @fetcher, neighbors: @neighbors
  end

  it 'fetches the movies and returns their neighbors' do
    @subject.find.must_equal @neighbors.find
  end
end
