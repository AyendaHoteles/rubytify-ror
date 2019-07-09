require 'grape-swagger'

module API
  module V1
    class Genres < Grape::API
      include API::V1::Defaults

      namespace :genres do
        route_param :genre_name do
          desc 'Pick a random song for a given genre'
          get :random_song do
            artists_ids = Artist.where("? = ANY(genres)", params[:genre_name]).pluck(:id)

            song = Song.where(artist_id: artists_ids).order('RANDOM()').first

            present song, with: API::Entities::Song
          end
        end
      end
    end
  end
end
