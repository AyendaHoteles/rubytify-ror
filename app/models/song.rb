class Song < ApplicationRecord
  belongs_to :album

  validates :name, presence: true
  validates :spotify_url, presence: true
  validates :spotify_id, presence: true

  class << self
    def random_song_by_genre(genre_name)
      artist = Artist.where(
        "array_to_string(genres, ',') ILIKE ?", "%#{genre_name}%"
      ).sample
      if artist.present?
        artist.albums.sample.songs.sample
      else
        nil
      end
    end
  end
end
