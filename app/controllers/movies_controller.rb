class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.includes(:genre).all.decorate.each(&:fetch_movies_api_data!)
  end

  def show
    @movie = Movie.includes(comments: :user).find(params[:id]).decorate
    @movie.fetch_movies_api_data!
  end

  def send_info
    @movie = Movie.find(params[:id]).decorate
    MovieInfoMailer.send_info(current_user, @movie).deliver_later

    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    MovieExporterJob.perform_later(current_user: current_user, file_path: "tmp/movies.csv")

    redirect_to root_path, notice: "Movies exported"
  end
end
