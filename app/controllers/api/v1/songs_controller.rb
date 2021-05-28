class Api::V1::SongsController < ApplicationController

   #GET /artists/:artist_id/albums
   def index
      @songs = Song.where("album_id = ?", params[:album_id])
      render json: @songs
   end
end
