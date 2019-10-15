class MovieDecorator < Draper::Decorator
  delegate_all

  MOVIES_API_IMAGES_URL = "https://pairguru-api.herokuapp.com/".freeze

  def cover
    "http://lorempixel.com/100/150/" +
      %w[abstract nightlife transport].sample +
      "?a=" + SecureRandom.uuid
  end

  def poster_url
    image_name = movies_api_data.to_h[:poster]

    return "" if image_name.blank?

    "#{MOVIES_API_IMAGES_URL}#{image_name}"
  end
end
