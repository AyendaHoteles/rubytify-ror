class Artist::GetAll

	def self.call()

		artist = Artist.all

		data = artist.map{ |artist|
			{
				id: artist.id,
				name: artist.name,
				image: artist.image,
				genres: artist.genres,
				popularity: artist.popularity,
				spotify_url: artist.spotify_url,

			}
		}

		response = {:success => true , data: data}
		status = 200
		return{response: response, status:status}

	end

end