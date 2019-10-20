class ArtistsController < ApplicationController
    def index
        @artists = Artist.all.order('popularity DESC')
        render json: { data: @artists.as_json(except: [:spotify_id, :created_at, :updated_at]) }
    end
end
