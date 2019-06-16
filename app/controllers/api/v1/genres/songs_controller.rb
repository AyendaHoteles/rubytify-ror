module Api
  module V1
    module Genres
      class SongsController < ApplicationController
        def index
          render json: Song.random!(albums), root: 'data'
        end

        private

        def artists
          @artists ||= Artist.by_genre(params[:genre_name])
        end

        def albums
          @albums ||= Album.where(artist: artists)
        end
      end
    end
  end
end
