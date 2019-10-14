module Spotify
  class ParserService
    def self.artist(spotify_response:)
      {
        id:          spotify_response["id"],
        name:        spotify_response["name"],
        image:       spotify_response["images"].first.dig("url"),
        genres:      spotify_response["genres"],
        popularity:  spotify_response["popularity"],
        spotify_url: spotify_response.dig("external_urls","spotify")
      }
    end

    def self.albums(spotify_response:)
      albums = spotify_response["items"]

      return nil if albums.empty?

      albums.map do |album|
        {
          id:           album["id"],
          name:         album["name"],
          image:        album["images"]&.first.dig("url"),
          total_tracks: album["total_tracks"],
          spotify_url:  album.dig("external_urls","spotify")
        }
      end
    end

    def self.songs(spotify_response:)
      songs = spotify_response["items"]

      return nil if songs.empty?

      songs.map do |song|
        {
          id:          song["id"],
          name:        song["name"],
          explicit:    song["explicit"],
          duration_ms: song["duration_ms"],
          spotify_url: song.dig("external_urls","spotify"),
          preview_url: song["preview_url"]
        }
      end
    end
  end
end