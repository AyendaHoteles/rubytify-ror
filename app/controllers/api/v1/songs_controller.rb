class Api::V1::SongsController < ApplicationController
  def index
    album = Album.find(params[:album_id])
    songs = album.songs
    render json: songs, root: 'data'
  end
end