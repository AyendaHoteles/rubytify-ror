class Album < ApplicationRecord

	def self.new_from_spotify_album(spotify_album)
		Album.new(
			name: spotify_album.name,
            image: spotify_album.images[0],
            spotify_url: spotify_album.external_urls,
            total_tracks: spotify_album.total_tracks, 
            spotify_id: spotify_album.id 
			)
    end
    #metodo para guardar album.
    def self.create_from_spotify_album(spotify_album)
        album = self.new_from_spotify_album(spotify_album)
        album.save
        album
    end
  
end
