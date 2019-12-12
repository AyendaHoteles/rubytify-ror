class Api::V1::AlbumsController < ApplicationController
  # GET /api/v1/artists/:artist_id/albums
  def index
    artist_id = params[:artist_id]
    @artist = Artist.find(artist_id)
    @albums = @artist.albums.select(:id, :name, :image, :total_tracks, :spotify_url)
    render json: { data: @albums }, status: :ok
  rescue ActiveRecord::RecordNotFound => exception
    render json: { error: exception.message }, status: :not_found
  end
end
