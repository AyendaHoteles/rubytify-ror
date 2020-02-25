# frozen_string_literal: true

module Api::V1
  class AlbumsController < ApplicationController
    before_action :find_artist

    def index
      albums = @artist.albums

      render json: albums, status: :ok
    end

    private

    def find_artist
      @artist = Artist.find(params[:artist_id])
    end
  end
end
