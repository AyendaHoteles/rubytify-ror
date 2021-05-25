class Api::V1::ArtistsController < ApplicationController
  before_action :set_artist, only: [:albums]

  # GET /api/v1//artists
  def index
    @artists = Artist.all.order(popularity: :desc)
    # render json: @artists
    render json: { data: @artists.as_json(only: %w[id name image genres popularity spotify_url]) }
  end

  # GET /api/v1//artists/1/albums
  def albums
    render json: { data: @artist.albums.as_json(only: %w[id name image spotify_url total_tracks]) }
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def artist_params
      params.require(:artist).permit(:name, :image, :popularity, :spotify_url)
    end
end
