class Api::V1::SongsController < ActionController::Base

  def songs
    album = Album.where(id: params[:id])
    if album.empty?
      render json: {message: "No matches found"}
    else
      songs = fields_songs(album.first.songs)
      render json: {data: songs}
    end
  end

  def random_song
    genre = params[:genre_name]

    artists = Artist.where("genres LIKE ?", "%#{genre}%")
    songs = []
    artists.each do |artist|
      songs << artist.songs
    end

    if songs.empty?
      render json: {message: "No matches found"}
    else
      song = fields_songs(songs.first).sample
      render json: {data: song}
    end
  end

  def fields_songs(songs)
    songs.as_json(except: %i(id spotify_id album_id created_at updated_at))
  end

end
