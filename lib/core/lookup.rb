require_relative "../encyclopedia/encyclopedia"
require_relative "repository"

class Lookup
  def initialize(args)
    @ids = args.fetch :ids
    @repository = args.fetch :repository, Repository.new
    @encyclopedia = args.fetch :encyclopedia, Encyclopedia.new
  end

  def entries
    repository.create encyclopedia.entries ids
  end

  private

  attr_reader :ids, :repository, :encyclopedia
end
