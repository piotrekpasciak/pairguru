module Api
  module V1
    class MoviesController < ::ActionController::API
      def index
        movies = ::Movie.all
        render json: ::MoviesSerializer.new(movies: movies).serialize, status: :ok
      end
    end
  end
end
