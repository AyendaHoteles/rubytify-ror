class Api::V1::AlbumsController < ApplicationController
  # GET /api/v1/artists/:artist_id/albums
  def index
    artist_id = params[:artist_id]
    @albums = Album
      .select(:id, :name, :image, :total_tracks, :spotify_url)
      .where(artist_id: artist_id)
    render json: { data: @albums }, status: :ok
  end
end
