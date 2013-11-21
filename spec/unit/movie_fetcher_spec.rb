require 'spec_helper'
require 'movie_fetcher'
require 'interfaces/fetcher'
require 'interfaces/movie_repository'
require 'interfaces/encyclopedia_lookup'

class MovieRepositoryDouble
  def initialize response = nil
    @response = response
  end

  def find
    @response
  end
end

class EncyclopediaLookupDouble
  def initialize args = {}
    @ids = args.fetch :ids, []
  end

  def entries
    @ids.map { |id| "record#{id}"}
  end
end

describe EncyclopediaLookupDouble do
  include EncyclopediaLookupInterfaceTest

  before do
    @subject = EncyclopediaLookupDouble.new
  end
end

describe MovieRepositoryDouble do
  include MovieRepositoryInterfaceTest

  before do
    @subject = MovieRepositoryDouble.new
  end
end

describe MovieFetcher do
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
    @lookup_class = EncyclopediaLookupDouble
    @repo = MovieRepositoryDouble.new repo_response
    @subject = MovieFetcher.new encyclopedia_lookup_class: @lookup_class, repository: @repo
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
