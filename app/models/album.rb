class Album < ApplicationRecord
  belongs_to :artist
  validates :name, :image, :spotify_url, :total_tracks, :spotify_id, presence: true
  has_many :songs
  validates_associated :songs
end
