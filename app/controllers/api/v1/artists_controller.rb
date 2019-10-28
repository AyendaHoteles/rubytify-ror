class Api::V1::ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :albums]

  def index
    render json: {data: Artist.order(popularity: :desc).collect(&:details) }, status: :ok
  end

  def show
    render json: { data: @artist.details }, status: :ok
  end

  def albums
    render json: { data: @artist.albums.collect(&:details) }, status: :ok
  end

  private
    def set_artist
      if !@artist = Artist.find_by(id: params[:id])
        render json: {message: "Product not found or disabled"}, status: :not_found
      end
    end
end
