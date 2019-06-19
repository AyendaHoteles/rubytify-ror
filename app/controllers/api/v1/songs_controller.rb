class Api::V1::SongsController < ApplicationController
  def index
    album = Album.find(params[:album_id])
    songs = album.songs
    render json: songs, root: 'data'
  end

  def random
    songs = Genre.find_by!(name: params[:genre_name]).songs
    song = songs[SecureRandom.random_number(songs.length - 1)]
    render json: song, root: 'data'
  end
end