class SpotifyFetcher

  require 'yaml'
  RSpotify.authenticate(Rails.application.credentials.spotify[:client_id], 
                      Rails.application.credentials.spotify[:client_secret])

	YAML.load_file('artists.yml')

	artists = YAML.load_file('artists.yml')["artists"]
	artists.each do |artist|
		fetch_and_create_artist(artist)
	end

	def fetch_and_create_artist
		artist = RSpotify::Artist.search(artist).first
		
		Artist.create(name: artist.name, image: artist.images.first["url"], 
										genres: artist.genres,  popularity: artist.popularity, 
										spotify_url: artist.external_urls["spotify"], 
										spotify_id: artist.id)
	end

	def fetch_and_create_album
		albums = RSpotify::Artist.search(artist).first.albums
		albums.each do |album|
			
		Album.create(name: album.name, image: album.images.first["url"],
									spotify_url: album.external_urls["spotify"], 
									spotify_id: album.id, total_tracks: album.total_tracks)
		
		end
	end

	def fetch_and_create_song
		album.tracks.each do |track|
			Song.create(name: track.name, spotify_url: track.external_urls["spotify"], 
										preview_url: track.preview_url, explicit: track.explicit, 
										spotify_id: track.id)
		end
	end
end 