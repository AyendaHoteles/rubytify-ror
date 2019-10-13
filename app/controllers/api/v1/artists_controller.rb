class Api::V1::ArtistsController < ApplicationController
  def index
    artists = Artist.all.map { |artist| artist.create_body }

    render json: {data: artists}, status: 200
  end
end
