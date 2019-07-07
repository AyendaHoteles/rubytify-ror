# frozen_string_literal: true

module Api
  module V1
    # Genres controller class
    #
    # Show action:
    #
    # Responsible for returning one random genre-song.
    # The algorithm is efficient enough to work with million+ rows.
    # Source: https://ducktypelabs.com/retrieving-random-records-in-rails/
    class GenresController < ApplicationController
      before_action :set_songs, only: %i[random_song]
      before_action :check_if_any_song, only: %i[random_song]

      def random_song
        song = @songs.offset(rand(@songs.count)).first

        if stale?(song)
          render(
            json: {
              data: SongSerializer.new(song)
            },
            status: :ok
          )
        end
      end

      private

      def set_songs
        @songs = Song.joins(album: :artist)
          .merge(Artist.by_genre(params[:genre_name]))
      end

      # When no songs found,
      # handle with JSON error response.
      def check_if_any_song
        return if @songs.exists?

        render(
          json: {
            error: I18n.t('not_enough_songs', genre_name: params[:genre_name])
          },
          status: :not_found
        )
      end
    end
  end
end
