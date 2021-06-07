class Api::V1::AlbumsController < ApplicationController
  #GET /api/v1/artists/:id/albums
  def index
    @albums = Album.where("artist_id = ?", params[:artist_id])
    render json: { data: @albums }, each_serializer: AlbumSerializer, status: :ok
  end
end
