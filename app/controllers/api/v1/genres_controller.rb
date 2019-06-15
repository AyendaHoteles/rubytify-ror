module Api
  module V1
    class GenresController < ApplicationController
      # get ramdom song by genre
      def song_by_genre
        artists = Artist.where("genres ~* ?", params[:genre_name])
        if !artists.empty?
          song = artists.sample.albums.sample.songs.sample.as_json(:except => [:id, :album_id, :updated_at, :created_at, :spotify_id])
          if song.nil?
            song = artists.sample.albums.sample.songs.sample.as_json(:except => [:id, :album_id, :updated_at, :created_at, :spotify_id])
          end
          render json: {status: 'SUCCESS', data: song}, status: :ok
        else
          render json: {status: 'FAILED', data: {name: 'Genre not found.'}}, status: :unprocessable_entity
        end
      end
    end
  end
end
