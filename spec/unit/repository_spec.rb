require 'spec_helper'
require 'repository'
require 'interfaces/repository'
require 'test_database_connection'

describe Repository do

  include RepositoryInterfaceTest

  let(:ids) { [1, 2] }

  def database
    @_database ||= TestDatabaseConnection.new
  end

  before do
    database.reset
    @subject = Repository.new
  end

  it 'creates nodes in the database'

  context 'there are no matching nodes in the database' do
    it 'returns the ids of the missing movies' do
      @subject.find(ids).must_equal({
        found: [],
        missing: ids
      })
    end
  end
end
