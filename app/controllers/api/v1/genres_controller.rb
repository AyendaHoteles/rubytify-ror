class Api::V1::GenresController < ApplicationController
  # GET /api/v1/genres/:id/random_song
  def random_song
    genre_name = params[:id]
    @song = Song
      .random_by_genre(genre_name)
      .map do |song|
        song.attributes.except(
          "id",
          "spotify_id",
          "album_id",
          "created_at",
          "updated_at",)
      end
    render json: { data: @song }, status: :ok
  end
end
