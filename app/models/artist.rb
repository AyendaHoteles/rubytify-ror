# frozen_string_literal: true

class Artist < ApplicationRecord
  has_many :albums

  validates :name,
            :image,
            :spotify_url,
            :spotify_id, presence: true

  scope :select_uuid, -> { pluck(:id) }
  scope :by_popularity, -> { order(popularity: :desc) }
  scope :by_genre, ->(genre) { where(':genre = ANY(genres)', genre: genre) }
end
