class Artist::GetAlbums

	def self.call(artist_id)

		artist = Artist.find(artist_id)

		if !artist
			response = {:success => false, msg: "Artist not found"}
			status = 404
			return{response: response, status:status}
		end

		data = artist.albums.map{ |album|
			{
				id: album.id,
				name: album.name,
				image: album.image,
				total_tracks: album.total_tracks,
				spotify_url: album.spotify_url,

			}
		}

		response = {:success => true , data: data}
		status = 200
		return{response: response, status:status}

	end

end