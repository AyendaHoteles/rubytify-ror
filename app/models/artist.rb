class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  has_many :songs, through: :albums
  serialize :genres, Array
  validates :name, :spotify_url, :spotify_id, presence: true
end
