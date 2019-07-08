class Api::V1::SongsController < ApplicationController
  def index
    album = Album.find(params[:id])
    if album
      if album.songs.any?
        render json: album.songs, adapter: :json_api, status: :ok
      else
        render json: {error: "The album doesn't have songs registered"}, status: 404
      end
    else
      render json: {error: "Album not found"}, status: 404
    end
  end
end
