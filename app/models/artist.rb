class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  has_many :songs, through: :albums
  serialize :genres, Array
  validates :spotify_id, presence: true
end
