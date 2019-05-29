class Album::GetSongs

	def self.call(album_id)

		album = Album.find(album_id)

		if !album
			response = {:success => false, msg: "Album not found"}
			status = 404
			return{response: response, status:status}
		end

		data = album.songs.map{ |song|
			{
				name: song.name,
				preview_url: song.preview_url,
				duration_ms: song.duration_ms,
				spotify_url: song.spotify_url,

			}
		}

		response = {:success => true , data: data}
		status = 200
		return{response: response, status:status}

	end

end