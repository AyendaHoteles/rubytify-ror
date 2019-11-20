module Spotify
  extend ActiveSupport::Concern

  def self.authenticate
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

  def self.auth_body
    @auth_body
  end

  def self.auth_code
    @auth_code
  end

  def self.auth_token
    "#{@auth_body["token_type"]} #{@auth_body["access_token"]}"
  end

  def self.fetch_artists
    return unless @auth_code == '200'

    headers = { "Authorization": self.auth_token }
    params = { "ids": "0oSGxfWSnnOXhD2fKuz2Gy,3dBVyJ7JuOMt4GE9607Qin" }

    self.http_get_request("https://api.spotify.com/v1/artists", headers, params)
  end

  private

  def self.http_post_request(url, headers, params)
    uri = URI(url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = /https/ === url
    request = Net::HTTP::Post.new(uri.path)
    headers.each { |k,v| request[k] = v }
    request.set_form_data(params)
    https.request(request)
  end

  def self.http_get_request(url, headers, params)
    uri = URI(url)
    uri.query = URI.encode_www_form(params)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = /https/ === url
    req = Net::HTTP::Get.new(uri)
    headers.each { |k,v| req[k] = v }
    https.request(req)
  end
end
