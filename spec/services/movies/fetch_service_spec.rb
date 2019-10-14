require "rails_helper"

describe Movies::FetchService do
  describe "#call" do
    context "when existing movie_name provided" do
      subject { described_class.new(movie_name: "The Dark Knight") }

      it "returns exchange rates collection" do
        result = VCR.use_cassette("movies_api/success_movie_name") do
          subject.call
        end

        result_value = result.value

        expect(result.success?).to eq true

        expect(result_value["title"]).to eq "The Dark Knight"
        expect(result_value["rating"]).to eq 9.0
        expect(result_value["poster"]).to eq "/the_dark_knight.jpg"
      end
    end

    context "when non existing movie_name provided" do
      subject { described_class.new(movie_name: "non_existing_movie_name") }

      it "returns error message" do
        result = VCR.use_cassette("movies_api/failure_movie_name") do
          subject.call
        end

        expect(result.success?).to eq false
        expect(result.value).to eq "Not Found"
      end
    end

    context "when network error was raised" do
      subject { described_class.new(movie_name: "The Dark Knight") }

      before do
        allow_any_instance_of(Net::HTTP).to receive(:request).and_raise(Errno::ECONNREFUSED) # rubocop:disable Metrics/LineLength
      end

      it "returns error message" do
        result = subject.call

        expect(result.success?).to eq false
        expect(result.value).to eq "Connection refused"
      end
    end
  end
end
