class AlbumsImportJob < ApplicationJob
  queue_as :default

  def perform(args = {})
    authenticate_to_spotify
    artist = RSpotify::Artist.find(args[:artist_spotify_id])
    albums = artist.albums
    albums.each { |album| create_or_update_album(album, args) }
  end

  private

  def create_or_update_album(album_data, args)
    spotify_id = album_data.id
    album = Album.find_or_create_by(spotify_id: spotify_id)
    album.update(
      name: album_data.name,
      image: album_data.images.size.positive? ? album_data.images[0]['url'] : nil,
      spotify_url: album_data.external_urls['spotify'],
      total_tracks: album_data.total_tracks,
      spotify_id: spotify_id,
      artist_id: args[:artist_id]
    )
  end
end
