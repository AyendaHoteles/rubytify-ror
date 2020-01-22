class Api::V1::ArtistsController < ApplicationController
    
    # GET /artists
    def index
        @artists = Artist.order(:popularity)
        render json: { data: @artists }, except: [:updated_at, :created_at, :spotify_id]
    end

    def albums
        @albums = Artist.find(params[:id])
        render json: { data: @albums }
    end
end