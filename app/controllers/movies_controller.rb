class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]
  before_action :load_movie, only: [:show, :send_info]

  def index
    @movies = Movie.all.decorate
  end

  def show
    @movie.fetch_movies_api_data!
  end

  def send_info
    MovieInfoMailer.send_info(current_user, @movie).deliver_now
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end

  private

  def load_movie
    @movie = Movie.find(params[:id]).decorate
  end
end
