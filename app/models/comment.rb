class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :message, presence: true
  validates :user_id, uniqueness: { scope: :movie_id }
end
