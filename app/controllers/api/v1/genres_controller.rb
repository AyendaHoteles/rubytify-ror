# frozen_string_literal: true

module Api::V1
  class GenresController < ApplicationController
    def index
      song_genre = RandomGenreService.new(params[:genre_name])
      song = song_genre.show

      render json: song, status: :ok
    end
  end
end
