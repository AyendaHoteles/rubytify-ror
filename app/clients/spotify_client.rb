class SpotifyClient
  require 'rspotify'

  def initialize
    RSpotify.authenticate(ENV["SPOTIFY-CLIENT-ID"], ENV["SPOTIFY-CLIENT-SECRET"])
  end

  def get_artist_data(artist_name)
    response = begin
      RSpotify::Artist.search(artist_name)
    rescue Timeout::Error
      nil
    end
    response.first
  end
end