class Api::V1::ArtistsController < ApplicationController

  #GET /api/v1/artists
  def index
    @artists = Artist.all.order("popularity DESC")
    render json: @artists, root: 'data', each_serializer: ArtistSerializer, adapter: :json, status: :ok
  end

end
