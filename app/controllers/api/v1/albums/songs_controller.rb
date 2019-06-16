module Api
  module V1
    module Albums
      class SongsController < ApplicationController
        def index
          render json: album.songs.sort_by(&:name), root: 'data'
        end

        private

        def album
          @album ||= Album.find(params[:album_id])
        end
      end
    end
  end
end
