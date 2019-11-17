class Api::V1::AlbumsController < ApplicationController
  def songs_album
    @songs = Song.select(:name, :spotify_url, :preview_url, :duration_ms, :explicit).where("album_id = ?", params[:id])
    render json: { data: @songs }
  end
end
