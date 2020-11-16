module Api
  module V1
      class AlbumsController < ApplicationController
        def index
          albums_service = AlbumsService.new
          @albums = albums_service.get_albums_by_artist('1dfeR4HaWDbWqFHLkxsg1d')
          render json: @albums
        end

        def songs_by_album
          album = Album.find_by(id: params[:id])
          if album.present?
            @songs = album.songs
            render json: @songs
          else
            render :json => {msg: "album with id #{params[:id]}, not found "}.to_json, :status => 404 
          end
        end
      end
  end
end