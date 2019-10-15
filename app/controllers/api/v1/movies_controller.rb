module Api
  module V1
    class MoviesController < ::ActionController::API
      before_action :load_movie, only: :show

      def index
        @movies = ::Movie.includes(:genre).all
        render json: serialized_movies, status: :ok
      end

      def show
        render json: serialized_movie, status: :ok
      end

      private

      def load_movie
        @movie = ::Movie.includes(:genre).find(params[:id])
      end

      def serialized_movies
        {
          movies: @movies.map do |movie|
            ::MovieSerializer.new(
              movie:              movie,
              with_genre_details: params[:with_genre_details]
            ).serialize
          end
        }
      end

      def serialized_movie
        ::MovieSerializer.new(
          movie:              @movie,
          with_movie_details: true,
          with_genre_details: params[:with_genre_details]
        ).serialize
      end
    end
  end
end
