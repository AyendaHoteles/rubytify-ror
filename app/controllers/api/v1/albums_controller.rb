# frozen_string_literal: true

module Api
  module V1
    # Albums controller class
    #
    # Index action:
    #
    # Responsible for listing artist-albums.
    class AlbumsController < ApplicationController
      before_action :set_artist, only: %i[index]

      def index
        albums = @artist.albums.includes(:image).all

        if stale?(albums)
          render(
            json: {
              data: albums.map { |album| AlbumSerializer.new(album) }
            },
            status: :ok
          )
        end
      end

      private

      def set_artist
        @artist = Artist.find(params[:artist_id])
      end
    end
  end
end
