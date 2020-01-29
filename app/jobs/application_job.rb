class ApplicationJob < ActiveJob::Base
  private

  def authenticate_to_spotify
    RSpotify.authenticate(
      ENV['SPOTIFY_CLIENT_ID'],
      ENV['SPOTIFY_CLIENT_SECRET']
    )
  end
end
