class Song < ApplicationRecord
  belongs_to :album
  validates :name, presence: true

  def self.random_by_genre(genre)
    artists = Artist.where("genres like ?", "% #{genre}\n%")
    albums = Album.where(artist_id: artists)
    where(album: albums).sample(1)[0]
  end
end
