# == Schema Information
#
# Table name: songs
#
#  id          :bigint           not null, primary key
#  duration_ms :integer
#  explicit    :boolean
#  name        :string
#  preview_url :string
#  spotify_url :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  album_id    :integer
#  genre_id    :integer
#

class Song < ApplicationRecord
  has_and_belongs_to_many :artists
  
  belongs_to :album
  belongs_to :genre

  validates :name, :spotify_url, presence: true

  def create_body
    {
      name:        self.name,
      spotify_url: self.spotify_url,
      preview_url: self.preview_url,
      duration_ms: self.duration_ms,
      explicit:    self.explicit
    }
  end

  def self.random_song(genre_name:)
    genre = Genre.find_by(name: genre_name)

    unless genre.nil?
      songs = Song.all.where(genre_id: genre.id)
    else
     return nil 
   end

    i = rand(0..songs.length)
    
    songs[i] if songs
  end
end
