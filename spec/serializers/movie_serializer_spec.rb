require "rails_helper"

describe MovieSerializer do
  subject { described_class.new(movie: movie) }

  describe "#serialize" do
    let(:movie) { create(:movie) }

    let(:expected_result) do
      {
        id:          movie.id,
        title:       movie.title,
        description: movie.description,
        released_at: movie.released_at
      }
    end

    it "serializes the object" do
      expect(subject.serialize).to eq expected_result
    end
  end
end
