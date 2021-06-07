class Api::V1::AlbumsController < ApplicationController
  #GET /api/v1/artists/:id/albums
  def index
    @albums = Artist.find(params[:artist_id]).albums
    render json: @albums, root: 'data', each_serializer: AlbumSerializer, adapter: :json, status: :ok
  end
end
