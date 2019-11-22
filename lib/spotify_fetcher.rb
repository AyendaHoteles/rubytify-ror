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
			artist = RSpotify::Artist.search(artist_name.to_s).first
			next if artist.blank?
			artist_created = Artist.create(name: artist.name, image: artist.images.first["url"], 
											genres: artist.genres,  popularity: artist.popularity, 
											spotify_url: artist.external_urls["spotify"], 
											spotify_id: artist.id)
			print "$"
			create_albums(artist.albums)
		end
	end

	def create_albums(albums)
		albums.each do |album|
			next if album.blank?

			album_created = Album.create(name: album.name, image: album.images.first["url"],
										spotify_url: album.external_urls["spotify"], 
										spotify_id: album.id, total_tracks: album.total_tracks)
			create_songs(album.tracks)
			print "*"
		end
	end

	def create_songs(tracks)
		tracks.each do |track|
			next if track.blank?

			song_created = Song.create(name: track.name, spotify_url: track.external_urls["spotify"], 
										preview_url: track.preview_url, explicit: track.explicit, 
										spotify_id: track.id)
			print "."
		end
	end

	protected

	def authenticate
		RSpotify.authenticate(Rails.application.credentials.spotify[:client_id], 
                      Rails.application.credentials.spotify[:client_secret])
	end
end
