require "rails_helper"

describe "Movies requests", type: :request do
  let!(:batman_movie) { create(:movie, title: "The Dark Knight") }

  describe "#index" do
    let!(:non_existing_movieS) { create_list(:movie, 3, title: "Non existing title") }

    it "displays movies list" do
      VCR.use_cassette("movies_api/success_movies_list") do
        visit "/movies"
      end

      expect(page).to have_selector("h1", text: "Movies")
      expect(page).to have_selector("h4", text: "The Dark Knight")
    end
  end

  describe "#show" do
    let(:user) { create(:user) }

    before do
      login_as user
    end

    context "when user adds valid comment" do
      it "creates comment and display success messages" do
        VCR.use_cassette("movies_api/success_movie_name") do
          visit movie_path(batman_movie)
        end

        fill_in "comment[message]", with: "Comment Message"
        click_on "Create"

        expect(page).to have_current_path(movie_path(batman_movie))
        expect(page).to have_http_status(:ok)
        expect(page).to have_selector("div#flash_notice", text: "Comment created successfully")
        expect(page).to have_selector("p", text: "Comment Message")
      end
    end

    context "when user tries to add invalid comment" do
      it "does not create comment and error message is displayed" do
        VCR.use_cassette("movies_api/success_movie_name") do
          visit movie_path(batman_movie)
        end

        click_on "Create"

        expect(page).to have_current_path(movie_path(batman_movie))
        expect(page).to have_http_status(:ok)
        expect(page).to have_selector("div#flash_error", text: "Message can't be blank")
      end
    end
  end
end
