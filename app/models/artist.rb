class Artist < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :spotify_id, presence: true
  validates :spotify_url, presence: true

  has_many :albums
  has_many :songs, through: :albums
  has_and_belongs_to_many :genres
end
