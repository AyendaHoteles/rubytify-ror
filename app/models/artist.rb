# == Schema Information
#
# Table name: artists
#
#  id          :bigint           not null, primary key
#  image       :string
#  name        :string
#  popularity  :integer
#  spotify_url :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  spotify_id  :string
#

class Artist < ApplicationRecord
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :songs
  has_many                :albums

  validates :name, :spotify_url, presence: true
  
  def self.create_artist(name:)
    puts "creating new artist #{name}"

    artist = find_artist(name: name)

    unless artist.empty?
      puts "Artist #{artist.first.name} was already created"
      return true
    end

    response = Spotify::ComunicationService.get_artist(name: name)
    
    if response.nil?
      puts "Artist #{name} could not be found in spotify"
      return false
    end

    response_parsed = Spotify::ParserService.artist(spotify_response: response)

    response_parsed[:genres].each { |genre_name| Genre.find_or_create_by(name: genre_name) } 

    begin 
      new_artist = Artist.create!(
        spotify_id:  response_parsed[:id],
        name:        response_parsed[:name],
        image:       response_parsed[:image],
        popularity:  response_parsed[:popularity],
        spotify_url: response_parsed[:spotify_url]
      )

      add_genres(artist: new_artist, genres_names: response_parsed[:genres])

      puts "new artist #{new_artist.name} was successfully created"

      return true
    rescue => e
      puts e
      puts "something went wrong create the new artist #{name}"
    end
  end
  
  def create_albums
    puts "creating all albums album of #{self.name}"

    response = Spotify::ComunicationService.get_albums(name: self.name)
    
    if response.nil?
      puts "Could not be found any album in spotify for #{self.name}"
      return false
    end
    
    response_parsed = Spotify::ParserService.albums(spotify_response: response)
    
    response_parsed.each do | album_params|
      next if Album.find_by(name: album_params[:name])
      
      new_album = self.albums.create!(   
        spotify_id:   album_params[:id],
        name:         album_params[:name],
        image:        album_params[:image],
        spotify_url:  album_params[:spotify_url],
        total_tracks: album_params[:total_tracks]
      )
    end

    puts "Albums were created for artist #{self.name}"
  end

  def create_body
    genres = self.genres

    {
      id:          self.spotify_id,
      name:        self.name,
      image:       self.image,
      genres:      genres.map(&:name).join(", "),
      popularity:  self.popularity,
      spotify_url: self.spotify_url
    }
  end

  private 
    def self.add_genres(artist:, genres_names:)
      genres_names.each do |name|
        artist.genres << Genre.find_by(name: name)
      end
    end

    def self.find_artist(name:)
      Artist.all.select do |artist|
        artist.name.split.map { |artist_name| /#{artist_name}/ =~ "#{name}"}.any?
      end
    end
end
