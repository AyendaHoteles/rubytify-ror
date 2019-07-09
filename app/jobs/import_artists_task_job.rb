class ImportArtistsTaskJob < ApplicationJob
  queue_as :default

  def perform(artist_names)
    SpotifyService.new.service_ejecution(artist_names)
  end
end
