module Api
  module V1
    class ArtistsController < ApplicationController
      def index
        @artists = Artist.order('artists.popularity DESC').all
        render json: Response.new(@artists.as_json)
      end
    end
  end
end