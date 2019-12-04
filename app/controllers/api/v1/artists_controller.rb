class Api::V1::ArtistsController < ApplicationController
require 'yaml'

  #mostrar artistas registrados en base de datos por el tasks
  def index
     @artists = Artist.all
     render json: {data:@artists}
  end
  
  #buscar albunes en spotify
  def albums
  	@artists = Artist.find(params[:id])
    albums  = RSpotify::Album.search(@artists.name)
  	@albums = albums.map do |s_albums|
    	Album.new_from_spotify_album(s_albums)
    end
    render json: {data:@albums}
  end

 
end
