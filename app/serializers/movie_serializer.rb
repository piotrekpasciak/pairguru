class MovieSerializer
  def initialize(movie:, with_movie_details: false, with_genre_details: false)
    @movie              = movie
    @with_movie_details = with_movie_details
    @with_genre_details = with_genre_details
  end

  def serialize
    if with_genre_details
      merged_movie_fields.merge!(genre: genre_details)
    else
      merged_movie_fields
    end
  end

  private

  attr_reader :movie, :with_movie_details, :with_genre_details
  delegate :genre, to: :movie

  def merged_movie_fields
    if with_movie_details
      movie_fields.merge!(movie_details)
    else
      movie_fields
    end
  end

  def movie_fields
    {
      id:          movie.id,
      title:       movie.title
    }
  end

  def movie_details
    {
      description: movie.description,
      released_at: movie.released_at
    }
  end

  def genre_details
    {
      id:               genre.id,
      name:             genre.name,
      number_of_movies: genre.movies.size
    }
  end
end
