class Api::V1::ArtistsController < ApplicationController

   #GET /artists
   def index
      @artists = Artist.all
      render json: @artists
   end
   
   #GET /artists/:id
   def show
      @artist = Artist.find_by_id(params[:id])
      render json: @artist
   end
   
end
