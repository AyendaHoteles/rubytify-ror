class Album < ApplicationRecord
  scope :artists_filter, ->(artists_ids) { where("artist_id IN (?)", artists_ids) }

  belongs_to :artist
  validates :name, :image, :spotify_url, :total_tracks, :spotify_id, presence: true
  has_many :songs
  validates_associated :songs
end
