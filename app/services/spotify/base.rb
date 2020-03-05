module Services::Spotify
  class Base
    include HTTParty
    debug_output $stdout
    base_uri 'https://api.spotify.com/v1/'

    CLIENT_ID = ENV['SPOTIFY_CLIENT_ID']
    CLIENT_SECRET = ENV['SPOTIFY_CLIENT_SECRET']
    TOKEN_URI = 'https://accounts.spotify.com/api/token'

    attr_reader :options, :service

    def initialize(service, params={})
      auth = "Bearer " + auth_token
      headers = { "Authorization" => auth }
      @service = service
      @options = { query: params, headers: headers }
    end

    private

    def auth_token
      auth = {username: CLIENT_ID, password: CLIENT_SECRET}
      HTTParty.post(TOKEN_URI,
        query: {
          grant_type: 'client_credentials'
        }, basic_auth: auth
      )['access_token']
    end
  end
end
