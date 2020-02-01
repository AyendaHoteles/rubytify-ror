class SpotifyAuthentication
  def auth
    RSpotify::authenticate(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'])
  rescue
    return {mssg: "RSpotify auth failed"}
  end
end

SpotifyAuthentication.new.auth