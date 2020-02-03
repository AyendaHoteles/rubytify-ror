module Api
  module V1
    class SongsController < ApplicationController
      def index
        render json: {data: data_wrapper(Album.find(params[:album_id]).songs)}
      end
    end
  end
end
