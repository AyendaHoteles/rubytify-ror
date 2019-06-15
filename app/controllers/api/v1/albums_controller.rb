module Api
  module V1
    class AlbumsController < ApplicationController
      #get all songs of an album
      def get_songs
        songs = Album.find(params[:id]).songs.select(:name, :spotify_url, :preview_url, :duration_ms, :explicit).as_json(:except => :id)
        if !songs.empty?
          render json: {status: 'SUCCESS', data: songs}, status: :ok
        else
          render json: {status: 'FAILED', data: {name: 'Album not found.'}}, status: :unprocessable_entity
        end
      end
    end
  end
end
