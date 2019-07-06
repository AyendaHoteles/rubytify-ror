# frozen_string_literal: true

module Api
  module V1
    # Articles controller class
    #
    # Index action:
    #
    # Responsible for listing artists sorted by popularity,
    # most popular are first.
    class ArtistsController < ApplicationController
      def index
        artists = Artist.order(popularity: :desc)

        if stale?(artists)
          render(
            json: {
              data: artists.map { |artist| ArtistSerializer.new(artist) }
            },
            status: :ok
          )
        end
      end
    end
  end
end
