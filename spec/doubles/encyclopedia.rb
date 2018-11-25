class EncyclopediaDouble
  def entries(ids)
    ids.map { |id| "movie#{id}" }
  end
end
