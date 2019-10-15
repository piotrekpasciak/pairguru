require "rails_helper"

describe MovieDecorator do
  describe "#poster_url" do
    context "when movies_api_data holds poster url" do
      let(:movie) { build(:movie, movies_api_data: { poster: "Batman" }).decorate }

      it "returns url to image" do
        expect(movie.poster_url).to eq "https://pairguru-api.herokuapp.com/Batman"
      end
    end

    context "when movies_api_data is nil" do
      let(:movie) { build(:movie).decorate }

      it "returns empty string" do
        expect(movie.poster_url).to eq ""
      end
    end
  end
end
