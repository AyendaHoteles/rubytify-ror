class Artist < ApplicationRecord
  has_many :albums, dependent: :delete_all
  has_many :songs, through: :albums

  validates :name, presence: true
  validates :image, presence: true
  validates :genres, presence: true
  validates :popularity, presence: true
  validates :spotify_url, presence: true
  validates :spotify_id, presence: true
end
