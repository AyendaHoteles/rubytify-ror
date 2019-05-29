require 'rspotify'

class SpotifyLoad::DataArtist

	def self.call(artist_name)

		artists = RSpotify::Artist.search(artist_name.to_s)

		artist_spotify = artists.first

		#verify artist exist in database
		artist = Artist.find_by_spotify_id(artist_spotify.id)

		if !artist
			artist = Artist.create(popularity: artist_spotify.popularity, genres: artist_spotify.genres.join(", "),
														 name: artist_spotify.name, spotify_id: artist_spotify.id,
														 spotify_url: artist_spotify.href, image: artist_spotify.images[0]['url'])
		end

		#load albumbs
		albums = artist_spotify.albums

		albums.each {|album|
			SpotifyLoad::DataAlbum.call(artist.id, album)
		}

	end

end