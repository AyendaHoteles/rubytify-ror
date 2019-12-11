class Api::V1::ArtistsController < ApplicationController
  # GET /api/v1/artists
  def index
    @artists = Artist
      .select(:id, :name, :image, :genres, :popularity, :spotify_url)
      .order(popularity: :desc)
    render json: { data: @artists }, status: :ok
  end
end
