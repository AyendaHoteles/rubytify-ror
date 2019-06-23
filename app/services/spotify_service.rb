class SpotifyService
	def initialize()
		cache = ActiveSupport::Cache::FileStore.new('/tmp/cache')
		unless cache.read('token_app')
			url = 'https://accounts.spotify.com/api/token'
			headers = {Authorization: "Basic #{Base64.strict_encode64("#{ENV['SPOTIFY_CLIENT_ID']}:#{ENV['SPOTIFY_CLIENT_SECRET']}")}"}
			params = {grant_type: 'client_credentials'}
			response = HTTParty.post(url, body: params, headers: JSON.parse(headers.to_json)).parsed_response
			cache.write('token_app', "#{response['token_type']} #{response['access_token']}")
		end
		@authorization = cache.read('token_app')
	end
end