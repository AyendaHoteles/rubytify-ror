module Api
  module V1
    class AlbumsController < ApplicationController
      def index
        render json: {data: data_wrapper(Artist.find(params[:artist_id]).albums)}
      end
    end
  end
end
