# frozen_string_literal: true

module Api
  module V1
    # Songs controller class
    #
    # Index action:
    #
    # Responsible for listing album-songs.
    class SongsController < ApplicationController
      before_action :set_album, only: %i[index]

      def index
        songs = @album.songs.all

        if stale?(songs)
          render(
            json: {
              data: songs.map { |song| SongSerializer.new(song) }
            },
            status: :ok
          )
        end
      end

      private

      def set_album
        @album = Rails.cache.fetch(
          "album/#{params[:album_id]}"
        ) do
          Album.find(params[:album_id])
        end
      end
    end
  end
end
