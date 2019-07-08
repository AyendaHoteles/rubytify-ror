class Api::V1::ArtistsController < ApplicationController
  def index
    artists = Artist.all
    if artists
      render json: artists, adapter: :json_api, status: :ok
    else
      render json: false, status: 404
    end
  end
end
