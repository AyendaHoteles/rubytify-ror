class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  # has_many :songs , through: :albums
  accepts_nested_attributes_for :albums

  def details
    {
      id: id, name: name, image: image, genres: genres.split(', '), popularity: popularity, spotify_url: spotify_url
    }
  end
end
