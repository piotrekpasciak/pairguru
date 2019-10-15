require "rails_helper"

describe MovieSerializer do
  describe "#serialize" do
    let(:movie) { create(:movie) }

    context "when movie provided" do
      subject { described_class.new(movie: movie) }

      let(:expected_result) do
        {
          id:          movie.id,
          title:       movie.title
        }
      end

      it "serializes the object" do
        expect(subject.serialize).to eq expected_result
      end
    end

    context "when with_movie_details param provided" do
      subject { described_class.new(movie: movie, with_movie_details: true) }

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

    context "when with_genre_details param provided" do
      context "when movie has genre" do
        subject { described_class.new(movie: movie, with_genre_details: true) }

        let(:expected_result) do
          {
            id:          movie.id,
            title:       movie.title,
            genre: {
              id:               movie.genre.id,
              name:             movie.genre.name,
              number_of_movies: movie.genre.movies.size
            }
          }
        end

        it "serializes the object" do
          expect(subject.serialize).to eq expected_result
        end
      end
    end
  end
end
