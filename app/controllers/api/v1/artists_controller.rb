module Api
  module V1
    class ArtistsController < ApplicationController
      def index
        @data = Artist.order(popularity: :desc)
      end
    end
  end
end
