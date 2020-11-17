class Album < ApplicationRecord
  belongs_to :artist
  has_many :songs, dependent: :destroy

  def album_has_songs
    self.songs.present?
  end
end
