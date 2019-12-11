class Api::V1::SongsController < ApplicationController
  # GET /api/v1/albums/:album_id/songs
  def index
    @songs = Song
      .select(:name, :spotify_url, :preview_url, :duration_ms, :explicit)
      .where(album_id: params[:album_id])
      .map { |song| song.attributes.except("id") } # select without :id leaves .id = nil instead of excluiding it
    render json: { data: @songs }, status: :ok
  end
end
