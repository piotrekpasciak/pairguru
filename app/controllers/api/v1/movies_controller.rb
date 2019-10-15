module Api
  module V1
    class MoviesController < ::ActionController::API
      before_action :load_movie, only: :show

      def index
        movies = ::Movie.all
        render json: ::MoviesSerializer.new(movies: movies).serialize, status: :ok
      end

      def show
        render json: ::MovieSerializer.new(movie: @movie).serialize, status: :ok
      end

      private

      def load_movie
        @movie = ::Movie.find(params[:id])
      end
    end
  end
end
