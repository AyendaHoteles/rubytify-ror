class Song < ApplicationRecord
  belongs_to :album
  has_one :artist, through: :album

  validates :album_id, :name, :spotify_id, presence: true
  validates :spotify_id, uniqueness: true

  def self.random_song_by_genre(genre_name)
    base_query = Song.joins(:artist).where("artists.genres @> '[\"#{genre_name}\"]'")
    base_query.limit(1).offset(rand(base_query.count)).first
  end
end
