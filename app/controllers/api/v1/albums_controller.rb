class Api::V1::AlbumsController < ApplicationController
    # GET /albums
    def index
        @albums = Album.all
        render json: { data: @albums }
    end
    
    def songs
        @album = Album.find(params[:id])
        @songs = Song.where(album_id: @album.id)
        render json: { data: @songs }
    end
end