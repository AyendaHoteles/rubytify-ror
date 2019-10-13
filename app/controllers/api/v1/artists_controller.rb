class Api::V1::ArtistsController < ApplicationController
  def index
    artists = Artist.all.map { |artist| artist.create_body }

    if artists.length > 0
      render json: {data: artists}, status: 200
    else
      render json: {errors: "No artist not found"}, status: 422
    end
  end
end
