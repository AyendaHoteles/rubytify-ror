class Api::V1::SongsController < ApplicationController

   #GET /api/v1/albums/:id/songs
   def index
      @songs = Song.where("album_id = ?", params[:album_id])
      render json: @songs, root: 'data', each_serializer: SongSerializer, adapter: :json
   end
end
