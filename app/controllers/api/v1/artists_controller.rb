class Api::V1::ArtistsController < ApplicationController
  def index
    render json: {data: Artist.all.order(popularity: :desc)}, status: :ok
  end
end
