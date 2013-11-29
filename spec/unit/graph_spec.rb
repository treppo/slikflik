require 'spec_helper'
require 'graph'
require 'test_database_connection'
require 'ducktypes/graph'

describe Graph do

  include Quacky::MiniTest::Matchers

  let(:ids) { [1, 2] }
  let(:units) { [
    { id: 1, title: 'title1' },
    { id: 2, title: 'title2' }
  ] }

  def database
    @_database ||= TestDatabaseConnection.new
  end

  before do
    database.reset
    @subject = Graph.new
  end

  it 'acts like a graph type' do
    assert_quacks_like @subject, GraphDucktype
  end

  it 'adds units to the database and returns the nodes' do
    nodes = @subject.add units

    nodes.length.must_equal 2
    database.node_count.must_equal 2
  end

  it 'creates unique nodes' do
    @subject.add units
    @subject.add units

    database.node_count.must_equal 2
  end

  it 'creates nodes with all properties' do
    node_1, node_2 = @subject.add units

    database.get_node_property(node_1, 'id').must_equal 1
    database.get_node_property(node_1, 'title').must_equal 'title1'
    database.get_node_property(node_2, 'id').must_equal 2
    database.get_node_property(node_2, 'title').must_equal 'title2'
  end

  it 'connects nodes' do
    nodes = @subject.add units

    @subject.connect nodes

    database.relationship_count.must_equal 1
  end

  it 'sets a zero weight on a new connection' do
    nodes = @subject.add units

    connection = @subject.connect nodes

    database.get_relationship_property(connection, 'weight').must_equal 0
  end

  it 'increases the weight of the connection' do
    nodes = @subject.add units
    connection = @subject.connect nodes

    @subject.increase_weight connection

    database.get_relationship_property(connection, 'weight').must_equal 1
  end

  it 'gets nodes' do
    node1 = @subject.add units

    @subject.get_nodes(ids).must_equal node1
  end

  it 'returns nil when a node does not exist' do
    @subject.get_nodes(ids).must_equal [nil, nil]
  end

  it 'gets connections' do
    nodes = @subject.add units
    expected = @subject.connect nodes

    actual = @subject.get_connection nodes

    actual.must_equal [expected]
  end

  it 'returns nil when a connection does not exist' do
    nodes = @subject.add units

    @subject.get_connection(nodes).must_be_nil
  end
end
