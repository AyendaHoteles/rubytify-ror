class ArtistsController < ApplicationController
    def index
        @artists = Artist.all
        render json: Response.new(@artists.as_json)
    end
end
