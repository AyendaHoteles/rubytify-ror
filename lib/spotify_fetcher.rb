class SpotifyFetcher
	attr_reader :artists

	def initialize
		@artists = YAML.load_file('artists.yml')["artists"]
	end

	def execute
		authenticate
		fetch_and_create_artists
	end 

	def fetch_and_create_artists
		artists.each do |artist_name|
			sleep(1)
			artist = RSpotify::Artist.search(artist_name.to_s).first
			next if artist.blank?
			artist_created = Artist.create!(name: artist.name, image: artist.images.first["url"], 
											genres: artist.genres,  popularity: artist.popularity, 
											spotify_url: artist.external_urls["spotify"], 
											spotify_id: artist.id)
			print "$"
			sleep(1)
			create_albums(artist.albums, artist_created.id)
		end
	end

	def create_albums(albums, artist_id)
		albums.each do |album|
			next if album.blank?

			album_created = Album.create!(name: album.name, image: album.images.first["url"],
										spotify_url: album.external_urls["spotify"], 
										spotify_id: album.id, total_tracks: album.total_tracks, artist_id: artist_id)
			print "*"
			sleep(1)
			create_songs(album.tracks, album_created.id)
		end
	end

	def create_songs(tracks, album_id)
		tracks.each do |track|
			next if track.blank?
			sleep(0.5)
			Song.create!(name: track.name, spotify_url: track.external_urls["spotify"], 
										preview_url: track.preview_url, explicit: track.explicit, 
										spotify_id: track.id, album_id: album_id)
			print "."
		end
	end

	protected

	def authenticate
		RSpotify.authenticate(Rails.application.credentials.spotify[:client_id],
                           Rails.application.credentials.spotify[:client_secret])
	end
end
