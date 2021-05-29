class Api::V1::AlbumsController < ApplicationController

   #GET /api/v1/artists/:id/albums
   def index
      @albums = Album.where("artist_id = ?", params[:artist_id])
      render json: @albums, root: 'data', each_serializer: AlbumSerializer, adapter: :json
   end
   
end
