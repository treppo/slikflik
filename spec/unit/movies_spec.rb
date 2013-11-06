require 'spec_helper'
require 'movies'
require 'database_connection'

describe Movies do

  subject { Movies }

  def ids
    [1, 2]
  end

  def database
    DatabaseConnection.new
  end

  before do
    database.reset
  end

  it { subject.must_respond_to :create }

  it 'creates nodes in the database' do
    database.nodes_count.must_equal 1 # root node

    subject.create ids

    database.nodes_count.must_equal 3
  end
end
