class Api::V1::ArtistsController < ApplicationController
  def index
    @artists = Artist.order(:popularity)
    #render json: @artists
    render json: { data: @artists }
  end
  
  def artist_albums
    @albums = Album.select(:spotify_id, :name, :image, :spotify_url, :total_tracks).where("artist_id = ?", params[:id])
    puts "El parametro: " + params[:id]
    render json: { data: @albums }
  end
end
