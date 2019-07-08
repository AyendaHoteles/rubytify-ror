class Artist < ApplicationRecord
  serialize :genres
  has_many :albums
  has_many :songs
  serialize :image
  scope :get_artists_by_genre, -> (genre_name) { where(" genres LIKE '%#{genre_name}%'") }
end
