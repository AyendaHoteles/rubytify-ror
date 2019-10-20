class AlbumsController < ApplicationController
    def songs
        begin
            album = Album.find(params[:id])
            render json: { data: album.songs.as_json(except: 
                [:id, :created_at, :updated_at, :album_id, :spotify_id]) }, status: :ok
        rescue => exception
            render json: {error: "album does not exist"}, status: 404 
        end
    end
end
