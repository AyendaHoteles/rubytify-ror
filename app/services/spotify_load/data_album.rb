class SpotifyLoad::DataAlbum

	def self.call(artist_id, album_spotify)

		album = Album.find_by_spotify_id(album_spotify.id)
		if !album
			album = Album.create(name: album_spotify.name, spotify_id: album_spotify.id,
														spotify_url: album_spotify.href, image: album_spotify.images[0]['url'],
														total_tracks: album_spotify.tracks.size, artist_id: artist_id  )
		end


		#load albumbs
		songs = album_spotify.tracks

		songs.each {|song|
			SpotifyLoad::DataSong.call(album.id, song)
		}

	end

end