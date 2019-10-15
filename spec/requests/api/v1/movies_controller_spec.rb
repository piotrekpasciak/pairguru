require "rails_helper"

describe Api::V1::MoviesController, type: :request do
  describe "#index" do
    let(:movie)   { create(:movie) }
    let!(:movies) { [movie] }

    let(:expected_response) do
      {
        movies: [
          {
            id:    movie.id,
            title: movie.title
          }
        ]
      }.to_json
    end

    it "renders successfull response" do
      get api_v1_movies_path

      expect(response).to have_http_status :ok
      expect(response.body).to eq expected_response
    end

    context "with with_genre_details param provided" do
      let(:expected_response) do
        {
          movies: [
            {
              id:    movie.id,
              title: movie.title,
              genre: {
                id:               movie.genre.id,
                name:             movie.genre.name,
                number_of_movies: movie.genre.movies.count
              }
            }
          ]
        }.to_json
      end

      it "renders successfull response" do
        get api_v1_movies_path(with_genre_details: "true")

        expect(response).to have_http_status :ok
        expect(response.body).to eq expected_response
      end
    end
  end

  describe "#show" do
    let!(:movie) { create(:movie) }

    let(:expected_response) do
      {
        id:          movie.id,
        title:       movie.title,
        description: movie.description,
        released_at: movie.released_at
      }.to_json
    end

    it "renders successfull response" do
      get api_v1_movie_path(movie)

      expect(response).to have_http_status :ok
      expect(response.body).to eq expected_response
    end

    context "with with_genre_details param provided" do
      let(:expected_response) do
        {
          id:          movie.id,
          title:       movie.title,
          description: movie.description,
          released_at: movie.released_at,
          genre: {
            id:               movie.genre.id,
            name:             movie.genre.name,
            number_of_movies: movie.genre.movies.count
          }
        }.to_json
      end

      it "renders successfull response" do
        get api_v1_movie_path(movie, with_genre_details: "true")

        expect(response).to have_http_status :ok
        expect(response.body).to eq expected_response
      end
    end
  end
end
