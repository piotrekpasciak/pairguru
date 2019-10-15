class MovieSerializer
  def initialize(movie:)
    @movie = movie
  end

  def serialize
    {
      id:          movie.id,
      title:       movie.title,
      description: movie.description,
      released_at: movie.released_at
    }
  end

  private

  attr_reader :movie
end
