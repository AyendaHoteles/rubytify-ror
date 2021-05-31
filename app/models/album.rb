class Album < ApplicationRecord
   belongs_to :artist
   has_many :songs
   
   def self.new_from_spotify_album(artist_id, spotify_album)
      Album.new(
         name: spotify_album.name,
         image: spotify_album.images[0],
         total_tracks: spotify_album.total_tracks,
         spotify_url: spotify_album.external_urls['spotify'],
         spotify_id: spotify_album.id,
         artist_id: artist_id
      )
   end
   
   def self.create_from_spotify_album(artist_id, spotify_album)
      if not self.exist_album(spotify_album.id)
         album = self.new_from_spotify_album(artist_id, spotify_album)
         album.save
         album
      else
         @album
      end
   end
   
   def self.exist_album(spotify_id)
      @album = Album.find_by(spotify_id: spotify_id)
      if @album
         return true
      else
         return false
      end
   end
end
