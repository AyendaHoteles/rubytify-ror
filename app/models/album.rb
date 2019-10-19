class Album < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :artist_id }
  validates_presence_of :spotify_id, :spotify_url, :total_tracks

  belongs_to :artist, validate: true
  has_many :songs
end
