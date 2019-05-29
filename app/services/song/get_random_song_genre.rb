class Song::GetRandomSongGenre

	def self.call(genre_name)

		artists = Artist.where('genres LIKE ?',"%#{genre_name}%")


		songs = []

		artists.each {|artist|
			artist.albums.each {|album|
				songs << album.songs
			}
		}

		song = songs.sample.first

		data =
			{
				name: song.name,
				preview_url: song.preview_url,
				duration_ms: song.duration_ms,
				spotify_url: song.spotify_url,

			}

		response = {:success => true , data: data}
		status = 200
		return{response: response, status:status}

	end

end