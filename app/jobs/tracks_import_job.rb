class TracksImportJob < ApplicationJob
  queue_as :default

  def perform(args = {})
    authenticate_to_spotify
    album = RSpotify::Album.find(args[:album_spotify_id])
    songs = album.tracks
    songs.each { |song| create_or_update_track(song, args) }
  end

  private

  def create_or_update_track(song_data, args)
    spotify_id = song_data.id
    song = Song.find_or_create_by(spotify_id: spotify_id)
    song.update(
      name: song_data.name,
      spotify_url: song_data.external_urls['spotify'],
      preview_url: song_data.preview_url,
      duration_ms: song_data.duration_ms,
      explicit: song_data.explicit,
      spotify_id: spotify_id,
      album_id: args[:album_id]
    )
  end
end
