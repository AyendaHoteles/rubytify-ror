class Api::V1::GenresController < ApplicationController
  # GET /api/v1/genres/:id/random_song
  def random_song
    genre_name = params[:id]
    @song = Song.random_by_genre genre_name
    render json: { data: @song }, status: :ok
  end
end
