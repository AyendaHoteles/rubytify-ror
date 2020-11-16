module Api
  module V1
      class ArtistsController < ApplicationController
        def index
          @artists = Artist.all.order(popularity: :desc)
          render json: @artists
        end

        def albums_by_artist
          artist = Artist.find_by(id: params[:id])
          if artist.present?
            @albums = artist.albums
            render json: @albums
          else
            render :json => {msg: "artist with id #{params[:id]}, not found "}.to_json, :status => 404 
          end
        end
      end
  end
end