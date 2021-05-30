class Artist < ApplicationRecord
   has_many :albums
   
   def self.new_from_spotify_artist(spotify_artist)
      Artist.new(
         name: spotify_artist.name,
         image: spotify_artist.images[0],
         genres: spotify_artist.genres,
         popularity: spotify_artist.popularity,
         spotify_url: spotify_artist.external_urls['spotify'],
         spotify_id: spotify_artist.id
      )
   end
   
   def self.create_from_spotify_artist(spotify_artist)
      unless self.exist_artist(spotify_artist.id)
         artist = self.new_from_spotify_artist(spotify_artist)
         artist.save
         artist
      end
   end
   
   def self.exist_artist(spotify_id)
      artist = Artist.find_by(spotify_id: spotify_id)
      if artist
         return true
      end
   end
end
