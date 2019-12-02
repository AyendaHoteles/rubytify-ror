class InsertSpotifyData

  def get_artist(artist_name)
    RSpotify::Artist.search(artist_name)&.last
  rescue
    return
  end

  def artists_names
    YAML.load_file(Rails.root.join('lib', 'spotify_data.yml'))['artists']
  end

  def save_data
    artists_names.each do |artist_name|
      artist_data = get_artist(artist_name)
      new_artist = save_artist(artist_data)
      save_genres(artist_data, new_artist)
      save_albums(artist_data, new_artist)
    end
  end

  def save_artist(artist_data)
    return if !artist_data
    Artist.create(
      name: artist_data.name,
      image: artist_data.images.first.try(:[], 'url'),
      popularity: artist_data.popularity,
      spotify_url: artist_data.href,
      spotify_id: artist_data.id
    )
  end

  def save_genres(artist_data, new_artist)
    return if !new_artist || !new_artist.persisted?
    artist_data.genres.each do |genre|
      new_artist.genres << return_genre(genre)
    end
  end

  def save_albums(artist_data, new_artist)
    return if !new_artist || !new_artist.persisted?
    artist_data.albums.each do |album_data|
      new_album = new_artist.albums.create(
        name: album_data.name,
        image: album_data.images.first.try(:[], 'url'),
        spotify_url: album_data.href,
        total_tracks: album_data.total_tracks,
        spotify_id: album_data.id
      )
      save_songs(album_data, new_album)
    end
  end

  def save_songs(album_data, new_album)
    return if !new_album || !new_album.persisted?
    album_data.tracks.each do |track|
      new_album.songs.create(
        name: track.name,
        spotify_url: track.href,
        preview_url: track.preview_url,
        duration_ms: track.duration_ms,
        explicit: track.explicit,
        spotify_id: track.id
      )
    end
  end

  def return_genre(genre)
    Genre.where(name: genre).last || Genre.create(name: genre)
  end

end
