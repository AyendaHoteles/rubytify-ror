class AlbumsController < ApplicationController
    def show
        @album = Album.find(params[:id])
        render json: { data: @album.songs.as_json(except: 
                        [:id, :created_at, :updated_at, :album_id, :spotify_id]) }, status: :ok
    end
end
