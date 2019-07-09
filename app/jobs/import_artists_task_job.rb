class ImportArtistsTaskJob < ApplicationJob
  queue_as :default

  def perform(artist_names)
    artists = create_artist(artist_names)
    service = SpotifyService.new
    service.update_artists(artists)
  end

  def create_artist(artist_names)
    artist_names.each do |artist|
      artist = Artist.create(name: artist)
    end
    artists = Artist.all
    artists
  end
end
