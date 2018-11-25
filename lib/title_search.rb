require "encyclopedia"

class TitleSearch
  def initialize(args)
    @title = args.fetch :title
    @encyclopedia = args.fetch :encyclopedia, Encyclopedia.new
  end

  def suggestions
    encyclopedia.search_title title
  end

  private

  attr_reader :title, :encyclopedia
end
