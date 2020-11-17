class GenresService

  def initialize
    
  end

  def get_song_by_gender_aleatory(params_genre)
    genre = Genre.find_by(name: params_genre)
    songs = get_songs_by_artist_aleatory(genre) if genre.present?
    get_song_aleatory(songs) if songs.present?
  end

  def get_songs_by_artist_aleatory(genre)
    songs = Song.includes(album: {artist: [:artist_genres]}).where( artist_genres: {genre_id: genre.id} )
  end

  def get_song_aleatory(songs)
    aleatory_song_position = generate_random_number(songs.size)
    songs[aleatory_song_position]
  end

  def generate_random_number(b)
    rand(0...b)
  end
end