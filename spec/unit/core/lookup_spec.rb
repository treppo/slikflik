require "spec_helper"
require "core/lookup"
require "interfaces/lookup"
require "doubles/encyclopedia"

describe Lookup do
  include LookupInterfaceTest

  before do
    @encyclopedia = EncyclopediaDouble.new
    @repository = Minitest::Mock.new
    @subject = Lookup.new ids: [1, 2], encyclopedia: @encyclopedia, repository: @repository
  end

  it "looks up movies in the encyclopedia and saves them in the repo" do
    @repository.expect :create, ["record1", "record2"], [["movie1", "movie2"]]
    @subject.entries.must_equal ["record1", "record2"]
  end
end
