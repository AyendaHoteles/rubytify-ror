class Album < ApplicationRecord
  belongs_to :artist
  has_many :songs,  dependent: :destroy
  accepts_nested_attributes_for :songs

  def details
    {
      id: id, name: name, image: image, spotify_url: spotify_url, total_tracks: total_tracks
    }
  end
end
