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
#  spotify_id   :string
#

class Album < ApplicationRecord
  belongs_to :artist
  has_many   :songs

  validates :name, :spotify_url, presence: true
  
  def create_songs
    puts "creating all the songs of the #{self.name} album"

    response = Spotify::ComunicationService.get_songs(album_id: self.spotify_id)
    
    if response.nil?
      puts "Could not be found any song in spotify for album #{self.name}"
      return false
    end
    
    response_parsed = Spotify::ParserService.songs(spotify_response: response)
    
    response_parsed.each do | song_params|
      next if Song.find_by(name: song_params[:name])
      
      new_song = self.songs.create!(   
        name:         song_params[:name],
        duration_ms:  song_params[:duration_ms],
        spotify_url:  song_params[:spotify_url],
        preview_url:  song_params[:preview_url],
        explicit:     song_params[:explicit],
        genre_id:     get_genre.id
      )
    end
    
    puts "Songs for album #{self.name} were created"
  end

  def create_body
    {
      id:           self.spotify_id,
      name:         self.name,
      image:        self.image,
      spotify_url:  self.spotify_url,
      total_tracks: self.total_tracks
    }
  end

  private 
    def self.find_album(name:)
      Album.all.select do |album|
        album.name.split.map { |album_name| /#{artist_name}/ =~ "#{name}"}.any?
      end
    end
    
    def get_genre
      self.artist.genres.first || Genre.all.first
    end
end
