module Spotify
  extend ActiveSupport::Concern
  class << self
    def authenticate
      client_id = 'dd06f329d5484973a7916a6066df137a'
      client_secret = '3c816c1a52664905a6a5052e6cd4f90e'
      key_base64 = Base64.strict_encode64("#{client_id}:#{client_secret}")

      params = { grant_type: 'client_credentials' }
      headers = {
        "Authorization": "Basic #{key_base64}",
        "Content-Type": 'application/x-www-form-urlencoded'
      }

      response = http_post_request('https://accounts.spotify.com/api/token', headers, params)
      @auth_body = JSON.parse(response.body)
      @auth_code = response.code
      response
    end

    def fetch_artist_by_name(name)
      return unless @auth_code == '200'

      headers = { "Authorization": auth_token }
      params = {
        "type": "artist",
        "q": name
      }
      http_get_request("https://api.spotify.com/v1/search", headers, params)
    end

    def fetch_artist_albumes(spotify_id)
      return unless @auth_code == '200'

      headers = { "Authorization": auth_token }
      http_get_request("https://api.spotify.com/v1/artists/#{spotify_id}/albums", headers)
    end

    def fetch_albumes_songs(spotify_id)
      return unless @auth_code == '200'
      
      headers = { "Authorization": auth_token }
      http_get_request("https://api.spotify.com/v1/albums/#{spotify_id}/tracks", headers)
    end

    def fetch_artist_by_names(spotify_ids)
      return unless @auth_code == '200'

      headers = { "Authorization": auth_token }
      params = { "ids": spotify_ids }
      http_get_request("https://api.spotify.com/v1/artists", headers, params)
    end

    def auth_body
      @auth_body
    end

    def auth_code
      @auth_code
    end

    def auth_token
      "#{@auth_body["token_type"]} #{@auth_body["access_token"]}"
    end

    private

    def http_post_request(url, headers, params={})
      uri = URI(url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = /https/ === url
      request = Net::HTTP::Post.new(uri.path)
      headers.each { |k,v| request[k] = v }
      request.set_form_data(params)
      https.request(request)
    end

    def http_get_request(url, headers, params={})
      uri = URI(url)
      uri.query = URI.encode_www_form(params)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = /https/ === url
      req = Net::HTTP::Get.new(uri)
      headers.each { |k,v| req[k] = v }
      https.request(req)
    end
  end
end
