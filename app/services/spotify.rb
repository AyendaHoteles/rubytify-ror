class Spotify
	RSpotify.authenticate("9e7cafb3fdc84abe984067fabdb60a4a", "fdc98c62f9154f66a94129ce2d12125b")
	
	def self.load_data
		artists_list = YAML.load_file('artist.yml')['artists']
		
		unless artists_list.blank?
			artists_list.each do |ar_lis|
				spot_artis = RSpotify::Artist.search(ar_lis.to_s).first
				if spot_artis
					albums = spot_artis.albums
					
					# songs = albums.tracks
					artist = Artist.new(
						name: spot_artis.name, image: spot_artis.images.sample(1)[0]['url'], genres: spot_artis.genres.join(', '), 
						popularity: spot_artis.popularity, spotify_url: spot_artis.external_urls['spotify'], spotify_id: spot_artis.id
					)

					artist.albums.build(album_details(albums))
					artist.save
					sleep(15.seconds)
				end
			end
		end
	end

	def self.album_details(albums)
		albums.map do |x|
			{
				name: x.name, image: x.images.sample(1)[0]['url'], spotify_url: x.external_urls['spotify'],
				total_tracks: x.tracks.size, spotify_id: x.id, songs: song_details(x.tracks)
			}
		end
	end

	def self.song_details(songs)
		songs.map do |x|
			Song.new(
				name: x.name, spotify_url: x.external_urls['spotify'], preview_url: x.preview_url, duration_ms: x.duration_ms,
				explicit: x.explicit, spotify_id: x.id
			)
		end
	end

	
end