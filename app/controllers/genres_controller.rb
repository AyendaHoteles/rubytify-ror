class GenresController < ApplicationController
  def random_song
    genre = Genre.find_by(name: params[:genre_name])
    if genre
      random_song = genre.artists.sample.albums.sample.songs.sample
      render json: random_song.as_json(except: 
        [:id, :created_at, :updated_at, :spotify_id, :album_id]), status: :ok
    else
      render json: {error: "genre not found"}, status: 404
    end
  end
end
