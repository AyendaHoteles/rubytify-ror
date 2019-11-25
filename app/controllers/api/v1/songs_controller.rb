class Api::V1::SongsController < ApplicationController
  def index
    songs = Song.where(album_id: params[:id])

    render json: {data: songs}, except: [:id, :spotify_id, :artist_id, :created_at, :updated_at], status: :ok
  end

  def random
    random_song = Song.random(params[:genre_name])
    render json: random_song, except: [:spotify_id, :artist_id, :created_at, :updated_at], status: :ok
  end
end
