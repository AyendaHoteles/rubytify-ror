class Song < ApplicationRecord
  belongs_to :album
  after_create :add_track_in_album
  after_destroy :remove_track_in_album

  private

  def add_track_in_album
    album.add_song
  end
  def remove_track_in_album
    album.remove_song
  end
end
