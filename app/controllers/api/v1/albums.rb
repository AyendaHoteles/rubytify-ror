require 'grape-swagger'

module API
  module V1
    class Albums < Grape::API
      include API::V1::Defaults

      namespace :albums do
        route_param :id do
          desc 'List all the Album Songs'
          get :songs do
            album = Album.find(params[:id])

            songs = album.songs

            present songs, with: API::Entities::Song
          end
        end
      end
    end
  end
end
