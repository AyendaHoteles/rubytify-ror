require 'grape-swagger'

module API
  module V1
    class Artists < Grape::API
      include API::V1::Defaults

      namespace :artists do
        desc 'List all the artists'

        get do
          artists = Artist.all

          present artists, with: API::Entities::Artist
        end

        route_param :id do
          desc 'List Artist Albums'
          get :albums do
            artist = Artist.find(params[:id])

            albums = artist.albums

            present albums, with: API::Entities::Album
          end
        end
      end
    end
  end
end
