class Movie

  attr_reader :id, :title, :poster_path

  def initialize properties
    @id = properties.fetch :id
    @title = properties.fetch :title
    @release_date = properties.fetch :release_date
    @poster_path = properties.fetch :poster_path
  end

  def to_h
    {
      id: id,
      title: title,
      release_date: @release_date,
      poster_path: poster_path
    }
  end

  def year
    Date.parse(@release_date).year
  end

  def == other
    id == other.id &&
      title == other.title &&
      year == other.year
  end
end
