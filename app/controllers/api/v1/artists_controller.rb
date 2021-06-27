require 'ostruct'
class Api::V1::ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :update, :destroy]

  # GET /artists
  def index
    @artists = Artist.all
             
    render json: "{data:#{@artists.to_json(only: [:id, :name, :image, :genres, :spotify_url, :popularity, :spotitify_id])}}"
    rescue => e
      return render json: { message: 'Is there an error. Try again' }, status: :not_found  
  end

  # GET /artists/
  def show
    arr = []
    arr.push(@artist.to_json(only: [:id, :name, :image, :genres, :spotify_url, :popularity]))
    render :show
    rescue => e
      return render json: { message: 'Is there an error. Try again' }, status: :not_found  
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def artist_params
      params.require(:artist).permit(:name, :image, :popularity, :genres, :spotify_url, :spotitify_id)
    end
end
