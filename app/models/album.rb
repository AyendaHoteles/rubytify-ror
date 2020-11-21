class Album < ApplicationRecord
  has_many :songs, dependent: :delete_all
  belongs_to :artist
  validates_presence_of :name, :spotify_url, :total_tracks, :spotify_id, :artist_id
end
