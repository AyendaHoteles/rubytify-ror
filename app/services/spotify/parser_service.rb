module Spotify
  class ParserService
    def self.artist(spotify_response:)
      {
        name:        spotify_response["name"],
        image:       spotify_response["images"].first["url"],
        genres:      spotify_response["genres"],
        popularity:  spotify_response["popularity"],
        spotify_url: spotify_response.dig("external_urls","spotify")
      }
    end
  end
end