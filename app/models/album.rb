class Album < ApplicationRecord
  belongs_to :artist
  has_many :songs, dependent: :destroy
  validates_presence_of :name, :image, :total_tracks, :spotify_url, :spotify_id
  validates :name, uniqueness: {
    scope: :total_tracks,
    message: "Avoid duplicated Albums"
  }
end
