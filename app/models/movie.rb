# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  released_at :datetime
#  avatar      :string
#  genre_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Movie < ApplicationRecord
  has_many :comments, dependent: :destroy

  belongs_to :genre, counter_cache: true

  validates :title, title_brackets: true

  attr_accessor :movies_api_data

  def fetch_movies_api_data!
    movie_cache_key = cache_key

    result = Rails.cache.fetch(movie_cache_key, expires_in: 24.hours) do
      Movies::FetchService.new(movie_name: title).call
    end

    if result.success?
      self.movies_api_data = result.value.symbolize_keys
    else
      Rails.cache.delete(movie_cache_key)
      self.movies_api_data = {}
    end
  end
end
