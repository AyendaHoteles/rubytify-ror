module Api
  module V1
    class AlbumsController < ApplicationController
      def index
      @data = Album.where(artist_id: params['artist_id'])
      end
    end
  end
end
