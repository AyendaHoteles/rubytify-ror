class Api::V1::AlbumsController < ApplicationController
    def index
      albums = Album.where(artist_id: params[:artist_id])

      render json: {data: albums}, except: [:spotify_id, :artist_id, :created_at, :updated_at], status: :ok
    end
end
