class Api::V1::ArtistsController < ApplicationController
  def index
    raise request.headers["authorization"]
    render json: { mancha: "gonorrea" }, status: :ok
  end
end
