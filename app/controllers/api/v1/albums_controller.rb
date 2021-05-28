class Api::V1::AlbumsController < ApplicationController

   #GET /artists/:artist_id/albums
   def index
      @albums = Album.where("artist_id = ?", params[:artist_id])
      render json: @albums
   end
   
   #GET /api/v1/artists/:artist_id/albums/:id
   def show
      @album = Album.find_by_id(params[:id])
      render json: @album
   end

end
