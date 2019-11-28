class Api::V1::AlbumsController < ApplicationController
  before_action :set_album, only: [:show]

  def index
    @albums = Album.all
    render json: @albums
  end

  def show
    @songs = @album.songs
    render json: @songs
  end

  private
  def set_album
    @album = Album.find(params[:id]) 
  end
end
