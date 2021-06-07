class Album < ApplicationRecord
  belongs_to :artist
  has_many :songs, dependent: :delete_all

  validates :name, presence: true
  validates :total_tracks, presence: true
  validates :spotify_url, presence: true
  validates :spotify_id, presence: true
  validates :artist_id, presence: true
end
