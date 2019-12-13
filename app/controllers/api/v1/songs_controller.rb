class Api::V1::SongsController < ApplicationController
  def index
    album = Album.find_by(id: params[:album_id])
    if album
      render json: album.songs, adapter: :json, root: 'data', status: :ok
    else
      render json: {}, status: :not_found
    end
  end
end
