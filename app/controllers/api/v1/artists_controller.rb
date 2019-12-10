class Api::V1::ArtistsController < ApplicationController
  # GET /api/v1/artists
  def index
    @artists = Artist.all
    render json: { data: @artists }, status: :ok
  end
end
