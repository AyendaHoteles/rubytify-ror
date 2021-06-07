class Api::V1::AlbumsController < ApplicationController
  #GET /api/v1/artists/:id/albums
  def index
    @artist = Artist.find_by(params[:id])
    #@albums = Album.where(artist_id: @artist.id)
    @albums = Album.where("artist_id = ?", params[:artist_id])
    render json: @albums, root: 'data', each_serializer: AlbumSerializer, adapter: :json, status: :ok
  end
end
