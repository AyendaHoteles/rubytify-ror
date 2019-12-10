class Api::V1::AlbumsController < ApplicationController
  # GET /api/v1/artists/:id/albums
  def index
    artist_id = params[:id]
    @albums = Album.where(artist_id: artist_id)
    render json: { data: @albums }, status: :ok
  end
end
