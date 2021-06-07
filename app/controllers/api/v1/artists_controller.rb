class Api::V1::ArtistsController < ApplicationController
  #GET /api/v1/artists
  def index
    @artists = Artist.all.order("popularity DESC")
    render json: { data: @artists }, each_serializer: ArtistSerializer, status: :ok
  end
end
