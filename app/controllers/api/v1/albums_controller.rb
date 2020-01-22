class Api::V1::AlbumsController < ApplicationController
    # GET /albums
    def index
        @albums = Album.all
        render json: { data: @albums }
    
    
    def songs
        @album = Album.find(params[:id])
        @songs = Album.where(albums_id: @album.id)
        render json: { data: @album }
    end
end