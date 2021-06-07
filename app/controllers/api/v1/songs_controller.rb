class Api::V1::SongsController < ApplicationController
  #GET /api/v1/albums/:id/songs
  def index
    @songs = Album.find(params[:album_id]).songs
    render json: @songs, root: 'data', each_serializer: SongSerializer, adapter: :json, status: :ok
  end
end
