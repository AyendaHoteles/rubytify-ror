class Api::V1::ArtistsController < ApplicationController
    def index
        @artists = Artist.order(popularity: :desc)
        render json: {data: @artists}
    end
end
