class Api::V1::ArtistsController < ApplicationController
    
    # GET /artists
    def index
        @artists = Artist.all
        render json: { data: @artists }
    end
end