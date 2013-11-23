require 'spec_helper'
require 'movie_net'
require 'test_database_connection'

describe MovieNet do

  subject { MovieNet }

  def movie_ids
    [1, 2]
  end

  def database
    @database ||= TestDatabaseConnection.new
  end

  before do
    database.reset
  end

  it { subject.must_respond_to :create }

  it 'creates movie nodes in the database' do
    subject.create(movie_ids).length.must_equal 2
  end

  it 'creates movie nodes with an id property' do
    node_1, node_2 = subject.create(movie_ids)

    database.get_node_property(node_1, 'id').must_equal 1
  end

  it 'creates unique movie nodes' do
    database.nodes_count.must_equal 1 # root node is always there

    subject.create movie_ids
    subject.create movie_ids

    database.nodes_count.must_equal 3
  end

  it 'creates movies findable by id in the database' do
    nodes = subject.create(movie_ids)

    database.find_movies(movie_ids).must_equal movie_ids
  end
end
