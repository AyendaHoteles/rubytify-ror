module Api
  module V1
    class ArtistsController < ApplicationController
      def index
        render json: Artist.all.sort_by(&:name), root: 'data'
      end
    end
  end
end    
