class Api::V1::GenresController < ApplicationController

  def random_song
    genre = Genre.find_by(name: params[:genre_name])
    song = genre.artists.sample.albums.sample.songs.sample
    rendering(song, %i[name spotify_url preview_url duration explicit])
  end
end
