class Api::V1::SongsController < ApplicationController
  # GET /api/v1/albums/:id/songs
  def index
    album_id = params[:id]
    @songs = Song.where(album_id: album_id)
    render json: { data: @songs }, status: :ok
  end
end
