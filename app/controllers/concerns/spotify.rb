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

    response = http_request('https://accounts.spotify.com/api/token', headers, params, 'post')

    @response_body = JSON.parse(response.body)
    @response_code = response.code

    response
  end

  def self.response_body
    @response_body
  end

  def self.response_code
    @response_code
  end

  def self.auth_token
    "#{@response_body["token_type"]} #{@response_body["access_token"]}"
  end

  def self.fetch_artist
    return unless @response_code == '200'

    headers = { "Authorization": self.auth_token }
    params = { "ids": "0oSGxfWSnnOXhD2fKuz2Gy,3dBVyJ7JuOMt4GE9607Qin" }

    self.http_request("https://api.spotify.com/v1/artists", headers, params, 'get')
  end

  private

  def self.http_request(url, headers, params, request_method)
    uri = URI(url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    request = case request_method.to_s.downcase
              when 'get'
                Net::HTTP::Get.new(uri.path)
              when 'post'
                Net::HTTP::Post.new(uri.path)
              end
    headers.each {|k,v| request[k] = v }
    request.set_form_data(params)
    https.request(request)
  end
end
