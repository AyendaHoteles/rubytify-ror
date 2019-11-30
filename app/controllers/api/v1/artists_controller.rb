class Api::V1::ArtistsController < ApplicationController
  include Spotify
  before_action :set_artist, only: [:show]


  def index
    @artists = Artist.all
    #@artists = testt
    #@artists = Artist.where("name LIKE '%"+ artic +"%'")
    #@artists = Artist.artist_name("metal")
        
    render json: @artists
  end

  #está bien hecho el show
  def show
    @albums = @artist.albums
    render json: @albums
  end

  private
  def set_artist
    @artist = Artist.find(params[:id]) 
  end

end
