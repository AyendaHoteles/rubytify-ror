class Artist < ApplicationRecord
  has_many :albums
  validates :name, :image, :popularity, :spotify_url, :spotify_id, presence: true
end
