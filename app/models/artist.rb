class Artist < ApplicationRecord
  # scope to get the artist that contains genre_name
  # on his genres array.
  # %\"#{genre_name}\"% synstax is used to look for the specific genre_name
  # and not variatios that contains it as genres is a string and not array
  scope :genre_filter, ->(genre_name) { where("genres LIKE ?", "%\"#{genre_name}\"%") }

  validates :name, :image, :genres, :popularity, :spotify_url, :spotify_id, presence: true
  has_many :albums
  validates_associated :albums
end
