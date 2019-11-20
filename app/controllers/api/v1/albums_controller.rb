class Api::V1::AlbumsController < ApplicationController
    def index
        albums = Album.select(:id, :name, :image, :spotify_url, :total_tracks)
                      .where(artist_id: params[:artist_id])
        render json: {data: albums}, status: :ok
    end
end
