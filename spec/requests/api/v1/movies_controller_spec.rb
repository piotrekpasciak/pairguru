require "rails_helper"

describe Api::V1::MoviesController, type: :request do
  describe "#index" do
    let!(:movies) { [create(:movie)] }

    let(:expected_response) { MoviesSerializer.new(movies: movies).serialize.to_json }

    it "renders successfull response" do
      get api_v1_movies_path

      expect(response).to have_http_status :ok
      expect(response.body).to eq expected_response
    end
  end
end
