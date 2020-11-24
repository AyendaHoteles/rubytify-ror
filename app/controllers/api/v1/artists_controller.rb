module Api
    module V1
        class ArtistsController < ApplicationController
            def index
                artists = Artist.all 
                render json: ArtistSerializer.new(artists).as_json
            end
            def show
                artist = Artist.find_by(id: params[:id])
                render json: ArtistSerializer.new(artists).serialized_json
            end           
        end    
    end
end    