class Artist < ApplicationRecord
  has_many :albums
  has_many :songs, through: :albums

  validates :name, presence: true
  validates :spotify_url, presence: true
  validates :spotify_id, presence: true
end
