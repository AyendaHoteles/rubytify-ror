# frozen_string_literal: true

module Api::V1
  class ArtistsController < ApplicationController
    def index
      artists = Artist.by_popularity

      render json: artists, status: :ok
    end
  end
end
