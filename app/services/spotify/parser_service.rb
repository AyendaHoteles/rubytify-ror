module Spotify
  class ParserService
    def self.artist(spotify_response:)
      {
        name:        spotify_response["name"],
        image:       spotify_response["images"].first.dig("url"),
        genres:      spotify_response["genres"],
        popularity:  spotify_response["popularity"],
        spotify_url: spotify_response.dig("external_urls","spotify")
      }
    end

    def self.album(spotify_response:)
      albums = spotify_response["items"]

      return nil if albums.empty?

      albums.map do |album|
        {
          name:         album["name"],
          image:        album["images"]&.first.dig("url"),
          total_tracks: album["total_tracks"],
          spotify_url:  album.dig("external_urls","spotify")
        }
      end
    end
  end
end