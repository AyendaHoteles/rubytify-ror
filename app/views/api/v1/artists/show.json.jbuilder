json.data do
		json.id @artist.spotify_id
		json.image @artist.image
		json.popularity @artist.popularity
		json.genres! @artist.genres
end