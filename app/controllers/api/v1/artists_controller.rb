class Api::V1::ArtistsController < ApplicationController
  def index
    puts Spotify.authenticate
    render json: { mancha: "gonorrea" }, status: :ok
  end
end
