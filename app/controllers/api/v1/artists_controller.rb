class Api::V1::ArtistsController < ApplicationController
  def index
    render json: { mancha: "gonorrea" }, status: :ok
  end
end
