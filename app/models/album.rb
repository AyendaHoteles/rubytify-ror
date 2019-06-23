class Album < ApplicationRecord
  belongs_to :artist
  has_many :songs, dependent: :destroy

  def add_song
    self.total_tracks += 1
    save
  end
  def remove_song
    self.total_tracks -= 1
    save
  end
end
