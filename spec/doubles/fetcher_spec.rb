require 'spec_helper'
require 'doubles/fetcher'
require 'interfaces/fetcher'

describe FetcherDouble do
  include FetcherInterfaceTest

  before do
    @subject = FetcherDouble.new
  end
end

