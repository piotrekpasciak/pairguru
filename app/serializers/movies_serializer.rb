class MoviesSerializer
  def initialize(movies:)
    @movies = movies
  end

  def serialize
    {
      movies: movies.map { |movie| movie_fields(movie) }
    }
  end

  private

  attr_reader :movies

  def movie_fields(movie)
    {
      id:    movie.id,
      title: movie.title
    }
  end
end
