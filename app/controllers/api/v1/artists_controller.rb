module Api
  module V1
    class ArtistsController < ApplicationController
      def index
        @data = Artist.all
      end
    end
  end
end
