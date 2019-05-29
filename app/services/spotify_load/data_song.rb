class SpotifyLoad::DataSong

	def self.call(album_id, song_spotify)

		song = Song.find_by_spotify_id(song_spotify.id)
		if !song
			song = Song.create(name: song_spotify.name, spotify_id: song_spotify.id,
												 spotify_url: song_spotify.href, preview_url: song_spotify.preview_url,
												 duration_ms: song_spotify.duration_ms, album_id: album_id,
												 explicit: song_spotify.explicit )
		end

	end

end