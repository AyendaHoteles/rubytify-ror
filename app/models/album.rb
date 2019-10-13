# == Schema Information
#
# Table name: albums
#
#  id           :bigint           not null, primary key
#  image        :string
#  name         :string
#  spotify_url  :string
#  total_tracks :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  artist_id    :integer
#

class Album < ApplicationRecord
  belongs_to :artist
  has_many   :songs

  validates :name, :spotify_url, presence: true
  
  private 
    def create_body
      {
        id:           self.id,
        name:         self.name,
        image:        self.image,
        spotify_url:  self.spotify_url,
        total_tracks: self.total_tracks
      }
    end

    def self.find_album(name:)
      Album.all.select do |album|
        album.name.split.map { |album_name| /#{artist_name}/ =~ "#{name}"}.any?
      end
    end
end
