class Api::V1::SongsController < ApplicationController
  def index
    album = Album.find_by(spotify_id: song_params[:id])
    songs = album&.songs

    if songs.present?
      render json: songs, each_serializer: SongsSerializer, status: :ok
    else
      render json: {}, status: 404
    end
  end

  private

  def song_params
    params.permit(:id)
  end
end
