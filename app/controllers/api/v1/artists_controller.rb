class Api::V1::ArtistsController < ApplicationController
  before_action :set_artist, only: [:show]


  def index
    @artists = Artist.all
    render json: @artists, each_serializer: ArtistSerializer
  end

  
  def show
    @albums = @artist.albums
    render json: @albums, each_serializer: AlbumSerializer
  end

  private
  def set_artist
    @artist = Artist.find(params[:id]) 
  end

end
