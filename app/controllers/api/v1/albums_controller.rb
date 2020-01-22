class Api::V1::AlbumsController < ApplicationController
    # GET /albums
    def index
        @artist = Artist.find(params[:id])
        @albums = Artist.where(artist_id: @artist.id)
        render json: { data: @albums }
    end
end