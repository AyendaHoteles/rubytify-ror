class SongsService
 
  def albums_service 
    @albums_service ||= AlbumsService.new
  end

  def get_songs_by_album_id(album_id)
    struct_data = false
    album = albums_service.get_album_by_id(album_id, struct_data)
    album.present? ? struct_data_songs(album.tracks) : nil
  end

  def struct_data_songs(songs)
    data = []
    songs.each do |song|
      data << struct_data_song(song) if song.present?
    end
    data
  end

  def struct_data_song(song)
    {
      name: song.name,
      explicit: song.explicit,
      preview_url: song.preview_url,
      duration_ms: song.duration_ms,
      spotify_id: song.id,
      spotify_url: song.href
    }
  end
end