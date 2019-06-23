class SpotifyService
	def initialize()
		cache = ActiveSupport::Cache::FileStore.new('/tmp/cache')
		unless cache.read('token_app')
			url = 'https://accounts.spotify.com/api/token'
			headers = {Authorization: "Basic #{Base64.strict_encode64("#{ENV['SPOTIFY_CLIENT_ID']}:#{ENV['SPOTIFY_CLIENT_SECRET']}")}"}
			params = {grant_type: 'client_credentials'}
			response = HTTParty.post(url, body: params, headers: JSON.parse(headers.to_json)).parsed_response
			cache.write('token_app', "#{response['token_type']} #{response['access_token']}", expires_in: response['expires_in'].seconds)
		end
		@headers = {Authorization: cache.read('token_app')}
	end

	def search_artist(artist)
		q = artist.gsub(/\s/,'%20')
		url = "https://api.spotify.com/v1/search?q=#{q}&type=artist"
		response = HTTParty.get(url, headers: JSON.parse(@headers.to_json)).parsed_response
		return nil unless response['artists']['total'].positive?
		artist_found = response['artists']['items'].first
		artist_db = Artist.find_or_create_by(spotify_id: artist_found['id'])
		artist_db.update(name: artist_found['name'], image: artist_found['images'].first['url'], genres: artist_found['genres'].join(', '), popularity: artist_found['popularity'], spotify_url: artist_found['href'])
		update_albums(artist_db)
		artist_db
	end

	private

	def update_songs(album)
		url = "https://api.spotify.com/v1/albums/#{album.spotify_id}/tracks"
		response = HTTParty.get(url, headers: JSON.parse(@headers.to_json)).parsed_response
		fill_songs(response['items'], album)
		# while !response['next'].blank?
		# 	response = get_more_data(response['next'])
		# 	fill_songs(response['items'], album)
		# end
	end

	def update_albums(artist)
		url = "https://api.spotify.com/v1/artists/#{artist.spotify_id}/albums"
		response = HTTParty.get(url, headers: JSON.parse(@headers.to_json)).parsed_response
		fill_albums(response['items'], artist)
		# while !response['next'].blank?
		# 	response = get_more_data(response['next'])
		# 	fill_albums(response['items'], artist)
		# end
	end

	def fill_songs(songs, album)
		songs.each do |song|
			song_db = album.songs.find_or_create_by(spotify_id: song['id'])
			song_db.update(name: song['name'], spotify_url: song['href'], preview_url: song['preview_url'], duration_ms: song['duration_ms'], explicit: song['explicit'])
		end
	end

	def fill_albums(albums, artist)
		albums.each do |album|
			album_db = artist.albums.find_or_create_by(spotify_id: album['id'])
			album_db.update(name: album['name'], image: album['images'].first['url'], spotify_url: album['href'])
			update_songs(album_db)
		end
	end

	def get_more_data(url)
		response = HTTParty.get(url, headers: JSON.parse(@headers.to_json)).parsed_response
	end
end