require 'spec_helper'
require 'fetcher'
require 'interfaces/fetcher'
require 'doubles/repository'
require 'interfaces/lookup'

class LookupDouble
  def initialize args = {}
    @ids = args.fetch :ids, []
  end

  def entries
    @ids.map { |id| "record#{id}"}
  end
end

describe LookupDouble do
  include LookupInterfaceTest

  before do
    @subject = LookupDouble.new
  end
end

describe Fetcher do
  include FetcherInterfaceTest

  def ids
    [1, 2]
  end

  let(:repo_response) do
    {
      found: ['record1', 'record2'],
      missing: []
    }
  end

  before do
    @lookup_class = LookupDouble
    @repo = RepositoryDouble.new repo_response
    @subject = Fetcher.new lookup_class: @lookup_class, repository: @repo, ids: ids
  end

  context 'all movies are found' do

    it 'returns the movie records' do
      @subject.movies.must_equal ['record1', 'record2']
    end
  end

  context 'only one movie is found' do

    let(:repo_response) do
      {
        found: ['record3'],
        missing: [4]
      }
    end

    it 'looks the missing up in the encyclopedia' do
      @subject.movies.must_equal ['record3', 'record4']
    end
  end

  context 'both movies are not found' do

    let(:repo_response) do
      {
        found: [],
        missing: [5, 6]
      }
    end

    it 'looks them up in the encyclopedia' do
      @subject.movies.must_equal ['record5', 'record6']
    end
  end
end
