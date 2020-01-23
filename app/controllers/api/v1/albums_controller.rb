class Api::V1::AlbumsController < ApplicationController
    # GET /albums
    def index
        @albums = Album.all
        render json: { data: @albums }
    end
    # GET /albums/:id/songs
    def songs
        @album = Album.find(params[:id])
        @songs = Song.where(album_id: @album.id)
        render json: { data: @songs }, except: [:spotify_id, :created_at, :updated_at, :album_id]
    end
end