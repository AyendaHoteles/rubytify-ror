class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  has_many :songs, through: :albums

  validates :name, :spotify_id, presence: true
  validates :spotify_id, uniqueness: true
end
