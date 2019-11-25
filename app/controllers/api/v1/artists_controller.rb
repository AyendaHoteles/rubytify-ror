class Api::V1::ArtistsController < ApplicationController

  def index
    artists = Artist.order_by_popularity
    render json: {data: artists}, except: [:spotify_id, :created_at, :updated_at], status: :ok
  end
end
