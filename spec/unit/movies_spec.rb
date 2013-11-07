require 'spec_helper'
require 'movies'
require 'database_connection'

describe Movies do

  subject { Movies }

  def movie_ids
    [1, 2]
  end

  def database
    @database ||= DatabaseConnection.new
  end

  before do
    database.reset
  end

  it { subject.must_respond_to :create }

  it 'creates movie nodes in the database' do
    subject.create(movie_ids).length.must_equal 2
  end

  it 'creates unique movie nodes' do
    database.nodes_count.must_equal 1 # root node is always there

    subject.create movie_ids
    subject.create movie_ids

    database.nodes_count.must_equal 3
  end
end
