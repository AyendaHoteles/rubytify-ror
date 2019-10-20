class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  validates :spotify_id, uniqueness: true
  validates_presence_of :name, :image, :genres, :popularity, :spotify_url, :spotify_id
end
