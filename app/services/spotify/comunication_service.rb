module Spotify
  class ComunicationService 
    SPOTIFY_KEY = ENV["SPOTIFY_BASE64"]

    def self.get_artist_id(name:)
      url = "https://api.spotify.com/v1/search?q=#{name}&type=artist"

      response = send_request(url: url)

      JSON.parse(response.body).dig("artists","items")&.first&.dig("id")
    end

    def self.get_artist(name:)
      artist_id = get_artist_id(name: name)
      
      if artist_id 
        response = send_request(url: artist_url(id: artist_id))
      else
        nil
      end
    end

    def self.get_albums(name:)
      artist_id = get_artist_id(name: name)
      
      if artist_id 
        response = send_request(url: albums_url(artist_id: artist_id))
      else
        nil
      end
    end

    def self.get_songs(album_id:)
      response = send_request(url: songs_url(album_id: album_id))
    end
    
    def self.send_request(url:)
      response = HTTParty.get(parse_url(url), 
        headers: {
          Authorization: "Bearer " + get_token,
        }
      )
    end
    
    def self.parse_url(url)
      URI.parse "#{URI.encode(url)}"
    end

    def self.get_token
      response = HTTParty.post("https://accounts.spotify.com/api/token",
        body:    {"grant_type" => "client_credentials"},
        headers: {
          Authorization: "Basic #{SPOTIFY_KEY}",
        }
      )
      
      JSON.parse(response.body)["access_token"]
    end

    def self.artist_url(id:)
      "https://api.spotify.com/v1/artists/#{id}" 
    end

    def self.albums_url(artist_id:)
      "https://api.spotify.com/v1/artists/#{artist_id}/albums" 
    end

    def self.songs_url(album_id:)
      "https://api.spotify.com/v1/albums/#{album_id}/tracks" 
    end
  end
end