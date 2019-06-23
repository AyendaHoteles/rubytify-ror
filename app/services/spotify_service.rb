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
		@authorization = cache.read('token_app')
	end

	def search_artist(artist)
		q = artist.gsub(/\s/,'%20')
		url = "https://api.spotify.com/v1/search?q=#{q}&type=artist"
		headers = {Authorization: @authorization}
		response = HTTParty.get(url, headers: JSON.parse(headers.to_json)).parsed_response
		return nil unless response['artists']['total'].positive?
		artist_found = response['artists']['items'].first
		artist_db = Artist.find_or_create_by(spotify_id: artist_found['id'])
		artist_db.update(name: artist_found['name'], image: artist_found['images'].first['url'], genres: artist_found['genres'].join(', '), popularity: artist_found['popularity'], spotify_url: artist_found['href'])
		artist_db
	end
end