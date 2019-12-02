class Album < ApplicationRecord

  belongs_to :artist
  has_many :songs

  validates :spotify_id, presence: true, uniqueness: true

  scope :get_albums_by_artist, -> (artist_id) { joins(:artist).where(artists: {id: artist_id}) }

end
