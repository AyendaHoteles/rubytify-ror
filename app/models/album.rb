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
    
    def create_songs
      puts "creating all the songs of the #{self.name} album"

      response = Spotify::ComunicationService.get_songs(name: self.name)
      
      if response.nil?
        puts "Could not be found any album in spotify for #{self.name}"
        return false
      end
      
      response_parsed = Spotify::ParserService.album(spotify_response: response)
      
      response_parsed.each do | album_params|
        next if Album.find_by(name: album_params[:name])
        
        new_album = self.albums.create!(   
          id:           album_params[:id],
          name:         album_params[:name],
          image:        album_params[:image],
          spotify_url:  album_params[:spotify_url],
          total_tracks: album_params[:total_tracks]
        )
      end

      puts "Albums were created for artist #{self.name}"
    end

    def self.find_album(name:)
      Album.all.select do |album|
        album.name.split.map { |album_name| /#{artist_name}/ =~ "#{name}"}.any?
      end
    end
end
