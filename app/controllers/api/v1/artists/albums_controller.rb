module Api
  module V1
    module Artists
      class AlbumsController < ApplicationController
        def index
          render json: artist.albums.sort_by(&:name), root: 'data'
        end

        private

        def artist
          @artist ||= Artist.find(params[:artist_id])
        end
      end
    end
  end
end    
