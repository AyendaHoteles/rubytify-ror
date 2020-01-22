class Api::V1::SongsController < ApplicationController
    # GET /genres/:genre_name/random_song
    def index
        @albums = Album.all
        render json: { data: @albums }
    
    
    def songs
        @album = Album.find(params[:id])
        @songs = Album.where(albums_id: @album.id)
        render json: { data: @album }
    end
end