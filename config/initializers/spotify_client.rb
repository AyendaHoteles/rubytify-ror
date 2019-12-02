class SpotifyClient
  def call
    RSpotify::authenticate("d41057152c144f8e82278a58a2302cc0", "e2d4c01efa914d2499c3ac9b48932195")
  rescue
    return
  end
end
SpotifyClient.new.call
