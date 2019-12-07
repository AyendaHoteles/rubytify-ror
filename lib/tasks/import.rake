namespace :import do
  desc "Import data from Spotify"
  task artists: :environment do
		def get_token
			client_id = '22ba8ac1b1e242a78ed3ab757b7b63f1'
			client_secret = 'b0d0a2eec98242c69e7a315ec50e790e'

			body = {grant_type: 'client_credentials'}
			credentials = {username: client_id, password: client_secret}
			response = HTTParty.post('https://accounts.spotify.com/api/token', body: body, basic_auth: credentials)
			@token = response.success? ? response.parsed_response["access_token"] : ''
	  end

		def search(q, type)
			return [] if @token.blank?
			params = {q: q, type: type}
			auth = {Authorization: "Bearer #{@token}"}
			response = HTTParty.get('https://api.spotify.com/v1/search', query: params, headers: auth)
			response.success? ? response.parsed_response : []
		end

		def artist_albums(artist_id)
			return [] if @token.blank?
			auth = {Authorization: "Bearer #{@token}"}
			response = HTTParty.get("https://api.spotify.com/v1/artists/#{artist_id}/albums", headers: auth)
			response.success? ? response.parsed_response : []
		end

		def album_songs(album_id)
			return [] if @token.blank?
			auth = {Authorization: "Bearer #{@token}"}
			response = HTTParty.get("https://api.spotify.com/v1/albums/#{album_id}/tracks", headers: auth)
			response.success? ? response.parsed_response : []
		end

		get_token

	  artists = YAML.load(File.read("artists.yml"))
	  artists["artists"].each do |artist_name|
	    
	    artist_list = search(artist_name, 'artist') 
	    artist_fetched = artist_list["artists"]["items"].first
	    
	    if artist_fetched
	      new_artist = Artist.find_or_create_by!(spotify_id: artist_fetched["id"])
	      new_artist.update!({
	        name: artist_fetched["name"],
	        image: artist_fetched["images"][0]["url"],
	        popularity: artist_fetched["popularity"],
	        spotify_url: artist_fetched["external_urls"]["spotify"]
	      })

        artist_fetched["genres"].each do |genre|
        	new_genre = Genre.find_or_create_by!(name: genre)
        	artist_genres = ArtistGenre.create({ artist_id: new_artist.id, genre_id: new_genre.id })
        end

	      new_albums = artist_albums(new_artist.spotify_id)
	      if new_albums
	        new_albums["items"].each do |album|
	          new_album = Album.find_or_create_by!(spotify_id: album["id"])
	          new_album.update!({
	            name: album["name"],
	            image: album["images"][0]["url"],
	            spotify_url: album["external_urls"]["spotify"],
	            total_tracks: album["total_tracks"],
	            spotify_id: album["id"],
	            artist_id: new_artist.id
	            
	          })

	          new_songs = album_songs(new_album.spotify_id)
			      if new_songs
			        new_songs["items"].each do |track|
			          new_track = Song.create({
			            name: track["name"],
			            spotify_url: track["external_urls"]["spotify"],
			            preview_url: track["preview_url"],
			            duration_ms: track["duration_ms"],
			            explicit: track["explicit"],
			            spotify_id: track["id"],
			            album_id: new_album.id
			          })
			          new_track.save!
			        end
			      end
	        end
	    	end
	    end
	  end
  end
end