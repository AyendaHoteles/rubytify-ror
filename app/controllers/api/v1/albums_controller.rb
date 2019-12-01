class Api::V1::AlbumsController < ApplicationController
  before_action :set_album, only: [:show]
  before_action :set_artist, only: [:index]

  def index
    @albums = @artist.albums

    render json: @albums, each_serializer: AlbumSerializer
  end

  def show
    @songs = @album.songs
    render json: @songs, each_serializer:  SongSerializer
  end

  private
  def set_album
    @album = Album.find(params[:id]) 
  end

  def set_artist
    @artist = Artist.find_by(id: params[:artist_id])
  end
end
