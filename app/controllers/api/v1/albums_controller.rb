class Api::V1::AlbumsController < ApplicationController
  before_action :set_album, only: [:show]

  # GET /api/v1/albums
  def index
    @albums = Album.all
    render json: @albums
  end

  # GET /api/v1/albums/1
  def show
    render json: { data: @album.songs.as_json(only: %w[name spotify_url preview_url duration_ms explicit ]) }
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(:name, :image, :spotify_url, :total_tracks, :spotify_id)
    end
end
