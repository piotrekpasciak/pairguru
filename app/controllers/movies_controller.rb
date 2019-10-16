class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]
  before_action :load_movie, only: [:show, :send_info]

  def index
    @movies = Movie.includes(:genre).all.decorate.each(&:fetch_movies_api_data!)
  end

  def show
    @movie.fetch_movies_api_data!
  end

  def send_info
    MovieInfoMailer.send_info(current_user, @movie).deliver_later

    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    MovieExporterJob.perform_later(current_user: current_user, file_path: "tmp/movies.csv")

    redirect_to root_path, notice: "Movies exported"
  end

  private

  def load_movie
    @movie = Movie.find(params[:id]).decorate
  end
end
