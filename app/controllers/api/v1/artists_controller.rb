class Api::V1::ArtistsController < ApplicationController
  def index
    artists = Artist.all
    if artists
      render json: { data: serializable_resource(artists) }, status: :ok
    else
      render json: false, status: 404
    end
  end
end
