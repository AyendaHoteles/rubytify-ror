class ImportArtistsTaskJob < ApplicationJob
  queue_as :default

  def perform(artist_names)
    create_artist(artist_names)
    service = SpotifyService.new
    service.update_artists
  end

  def create_artist(artist_names)
    artist_names.each do |artist|
      artist = Artist.create(name: artist)
    end
  end
end
