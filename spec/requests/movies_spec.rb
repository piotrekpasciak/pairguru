require "rails_helper"

describe "Movies requests", type: :request do
  let!(:batman_movie)       { create(:movie, title: "The Dark Knight") }
  let!(:non_existing_movie) { create_list(:movie, 3, title: "Non existing title") }

  describe "movies list" do
    it "displays movies list" do
      VCR.use_cassette("movies_api/success_movies_list") do
        visit "/movies"
      end

      expect(page).to have_selector("h1", text: "Movies")
      expect(page).to have_selector("h4", text: "The Dark Knight")
    end
  end
end
