class SpotifyService
  def initialize
    @client = SpotifyClient.new
  end

  def service_ejecution(artist_names)
    create_artist(artist_names)
    update_artists
  end

  def create_artist(artist_names)
    artist_names.each do |artist|
      artist = Artist.create(name: artist)
    end
  end

  def update_artists
    artists = Artist.all
    artists.each do  |artist|
      data = @client.get_artist_data(artist.name)
      if data
        update_artist(data, artist)
        create_albums(artist, data.albums)
      end
    end
  end

  def update_artist(data, artist)
    artist.update(genres: data.genres,
                    popularity: data.popularity,
                    spotify_url: data.external_urls["spotify"],
                    spotify_id: data.id,
                    image: data.images)
  end

  def create_albums(artist, albums)
   albums.each do |data_album|
      album = Album.create(artist_id: artist.id,
                           name: data_album.name,
                           spotify_url: data_album.external_urls["spotify"],
                           total_tracks: data_album.tracks.count,
                           spotify_id: data_album.id,
                           image: data_album.images)
      create_songs(artist, album, data_album.tracks) if album.persisted?
    end
  end

  def create_songs(artist, album, tracks)
    tracks.each do |track|
      Song.create(artist: artist, album: album,
                         name: track.name,
                         spotify_url: track.external_urls["spotify"],
                         preview_url: track.preview_url,
                         duration_ms: track.duration_ms,
                         explicit: track.explicit,
                         spotify_id: track.id)
    end
  end
end