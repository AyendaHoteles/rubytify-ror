class Api::V1::ArtistsController < ApplicationController
  def index
    render json: {data: Artist.all}, status: :ok
  end
end
