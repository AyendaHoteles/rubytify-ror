module Api
  module V1
    class GenresController < ApplicationController
      def random_song
        render json: {data: data_wrapper(Genre.find_by(name: params[:genre_name]).artists.sample.songs.sample)}
      end
    end
  end
end
