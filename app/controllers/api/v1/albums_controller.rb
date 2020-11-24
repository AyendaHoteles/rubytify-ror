module Api
    module V1
        class AlbumsController < ApplicationController
            def index
                albums = Album.where(artist_id: params[:artist_id])
                render json: AlbumSerializer.new(albums).as_json
            end       
        end    
    end
end    