class ImportArtistsTaskJob < ApplicationJob
  queue_as :default

  def perform(artist_names)
    artist_names.each do |artist|
      Artist.create(name: artist)
    end
    artists = Artist.all
    service = SpotifyService.new
    service.update_artists(artists)
  end
end
