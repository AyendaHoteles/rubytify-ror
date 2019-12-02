class Song < ApplicationRecord

  belongs_to :album

  validates :spotify_id, presence: true, uniqueness: true

  scope :get_songs_by_album, -> (album_id) { joins(:album).where(albums: {id: album_id}) }
  scope :get_random_song, -> (genre_name) { joins(album: [artist: :genres]).where(genres: {name: genre_name}).distinct }

end
