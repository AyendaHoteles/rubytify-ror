class Api::V1::SongsController < ApplicationController
  # GET /api/v1/albums/:album_id/songs
  def index
    @album = Album.find(params[:album_id])
    # select without :id leaves .id = nil instead of excluiding it
    @songs = @album.songs.
      select(:name, :spotify_url, :preview_url, :duration_ms, :explicit).
      map { |song| song.attributes.except("id") }
    render json: { data: @songs }, status: :ok
  rescue ActiveRecord::RecordNotFound => exception
    render json: { error: exception.message }, status: :not_found
  end
end
