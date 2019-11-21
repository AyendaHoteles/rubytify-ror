class Api::V1::AlbumsController < ApplicationController
  def index
    artist = Artist.find_by(spotify_id: album_params[:id])
    albums = artist&.albums

    if albums.present?
      render json: albums, each_serializer: AlbumsSerializer, status: :ok
    else
      render json: {}, status: 404
    end
  end

  private

  def album_params
    params.permit(:id)
  end
end
