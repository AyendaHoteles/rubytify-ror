class SpotifyService

  def artist_service
    @artist_service ||= ArtistsService.new
  end

  
  def albums_service
    @albums_service ||= AlbumsService.new
  end
  
  def songs_service
    @songs_service ||= SongsService.new
  end

  def create_artist(data)
    new_artist = Artist.new(data.except(:genres, :albums))
    if new_artist.save
      create_genres(new_artist, data[:genres]) if data[:genres].present?
      create_albums(new_artist, data[:albums]) if data[:albums].present?
    end
  end

  def create_genres(artist, genres)
    genres.each do |genre_spotify|
      genre = Genre.find_or_create_by(name: genre_spotify)
      artist_gender = ArtistGenre.new(artist_id: artist.id, genre_id: genre.id)
      artist_gender.save
    end
  end

  def create_albums( artist, albums )
    albums.each do |album|
      exist_album = Album.find_by( spotify_id: album[:spotify_id] )
      if !exist_album
        new_album = Album.new(album.except(:tracks))
        new_album.artist_id = artist.id
        if new_album.save 
          create_songs( new_album, album[:tracks] ) if album[:tracks].present?
        end
      end
    end
  end

  def create_songs( album, songs )
    songs.each do |song|
      exist_song = Song.find_by( spotify_id: song[:spotify_id] )
      if !exist_song
        new_song = Song.new(song)
        new_song.album_id = album.id
        new_song.save
      end
    end
  end

  def migration_data_by_artist(artists_name)
    artist_exist = Artist.find_by(name: artists_name)
    artist = artist_service.get_artist_by_name(artists_name) if !artist_exist.present?
    if artist.present?
      new_artist = create_artist(artist)
    end
  end

  def migration_albums_by_artist(artist)
    albums = albums_service.get_albums_by_artist(artist.spotify_id)
    create_albums(artist, albums)
  end

  def migration_songs_by_album(album)
    songs = songs_service.get_songs_by_album_id(album.spotify_id)
    create_songs(album, songs)
  end
end