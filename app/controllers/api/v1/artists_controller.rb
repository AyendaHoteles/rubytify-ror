module Api
  module V1
    class ArtistsController < ApplicationController
      def index
        render json: {data: data_wrapper(Artist.all.order(popularity: :desc))}
      end

      def create
        render json: Artist.create!(
            artist_create_permitted_params
        )
      rescue StandardError => exception
        render json: {
            mssg: "There was a problem creating this Artist"
        }, status: :unprocessable_entity
      end

      private

      def artist_create_permitted_params
        params.require(:artist).permit(:name, :image, :popularity, :spotify_id, :spotify_url)
      end
    end
  end
end
