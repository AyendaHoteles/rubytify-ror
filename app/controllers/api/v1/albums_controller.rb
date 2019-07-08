class Api::V1::AlbumsController < ApplicationController
  def index
    artist = Artist.find(params[:artist_id])
    if artist
      if artist.albums.any?
      render json: artist.albums, adapter: :json_api, status: :ok
      else
        render json: {error: "The artist doesn't have albums"}, status: 404
      end
    else
      render json: {error: "Artist not found"}, status: 404
    end
  end
end
