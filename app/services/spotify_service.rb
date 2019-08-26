require "net/http"
require "dotenv"
require "base64"


Dotenv.load(".env")


class SpotifyService
  def initialize()
    @auth = "#{ENV["CLIENT_ID"]}:#{ENV["CLIENT_SECRET"]}"
    @auth_64 = "Basic " + Base64.strict_encode64(@auth)
  end

  def update_token()
    uri = URI.parse('https://accounts.spotify.com/api/token')
    request = post_request(
      uri, 
      @auth_64,
      "application/x-www-form-urlencoded"
    )
    request.set_form_data("grant_type" => "client_credentials")
    response = Net::HTTP.start(
      uri.hostname, 
      uri.port, 
      get_options(uri)
    ) do |http|
      http.request(request)
    end
    if response.code === '200'
      body = JSON.parse(response.body)
      @access_token = "#{body["token_type"]} #{body["access_token"]}"
    else
      @access_token = nil
      puts 'Initialization error'
    end
  end

  def get_artist(artist_name)
    uri = URI.parse(
      "https://api.spotify.com/v1/search?q=#{artist_name}&type=artist"
    )
    request = get_request(uri, @access_token)
    response = Net::HTTP.start(
      uri.hostname, 
      uri.port, 
      get_options(uri)
    ) do |http|
      http.request(request)
    end
    if response.code === '200'
      body = JSON.parse(response.body)
      if body["artists"]["items"].length > 1
        artist = body["artists"]["items"][0]
        artist
      else
        nil
      end
    else
      nil
    end
  end

  def get_albums(artist_id, offset="0", limit="50")
    uri = URI.parse(
      "https://api.spotify.com/v1/artists/#{artist_id}/albums?offset=#{offset}&limit=#{limit}"
    )
    request = get_request(uri, @access_token)
    response = Net::HTTP.start(
      uri.hostname, 
      uri.port, 
      get_options(uri)
    ) do |http|
      http.request(request)
    end
    if response.code === '200'
      body = JSON.parse(response.body)
      if body["items"].length > 1
        albums = body["items"]
        albums
      else 
        nil
      end
    else
      nil
    end
  end

  def get_songs(album_id, offset="0", limit="50")
    uri = URI.parse(
      "https://api.spotify.com/v1/albums/#{album_id}/tracks?offset=#{offset}&limit=#{limit}"
    )
    request = get_request(uri, @access_token)
    response = Net::HTTP.start(
      uri.hostname, 
      uri.port, 
      get_options(uri)
    ) do |http|
      http.request(request)
    end
    if response.code === '200'
      body = JSON.parse(response.body)
      if body["items"].length > 1
        songs = body["items"]
        songs
      else 
        nil
      end
    else
      nil
    end
  end

  private
  def post_request(uri, auth, content_type)
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = auth
    request["Content-Type"] = content_type
    request
  end

  def get_request(uri, auth)
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = auth
    request
  end

  def get_options(uri)
    req_options = {
      use_ssl: uri.scheme == "https",
    }
    req_options
  end 
end