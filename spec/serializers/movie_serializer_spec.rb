require "rails_helper"

describe MoviesSerializer do
  subject { described_class.new(movies: movies) }

  describe "#serialize" do
    let(:movie)  { create(:movie) }
    let(:movies) { [movie] }

    let(:expected_result) do
      {
        movies: [
          {
            id:    movie.id,
            title: movie.title
          }
        ]
      }
    end

    it "serializes the object" do
      expect(subject.serialize).to eq expected_result
    end
  end
end
