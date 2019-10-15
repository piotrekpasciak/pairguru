module Movies
  class FetchService < ::BaseService
    MOVIES_API_URL = "https://pairguru-api.herokuapp.com/api/v1".freeze
    LOGGER_URL     = "log/movies_api.log".freeze

    def initialize(movie_name:)
      @movie_name = movie_name
    end

    def call
      uri      = URI.parse(URI.escape("#{MOVIES_API_URL}/movies/#{movie_name}"))
      http     = prepare_http_object(uri)

      response = http.request(Net::HTTP::Get.new(uri.request_uri))

      if response.code == "200"
        success(find_movie_attributes(response))
      else
        handle_failure(response)
      end
    rescue *CONNECTION_ERRORS => error
      handle_failure(error)
    end

    private

    attr_accessor :movie_name

    def prepare_http_object(uri)
      Net::HTTP.new(uri.host, uri.port).tap do |http|
        http.use_ssl      = true
        http.read_timeout = 2
      end
    end

    def find_movie_attributes(response)
      JSON.parse(response.body).dig("data", "attributes")
    end

    def handle_failure(error)
      Logger.new(LOGGER_URL).error("##{movie_name} - #{error.message}")
      failure(error.message)
    end
  end
end
