# frozen_string_literal: true

module Api::V1
  class SongsController < ApplicationController
    before_action :find_album

    def index
      songs = @album.songs

      render json: songs, status: :ok
    end

    private

    def find_album
      @album = Album.find(params[:album_id])
    end
  end
end
