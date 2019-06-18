# frozen_string_literal: true

# == Route Map
#
#                    Prefix Verb URI Pattern                                                                              Controller#Action
#        api_v1_album_songs GET  /api/v1/albums/:album_id/songs(.:format)                                                 api/v1/songs#index
#      api_v1_artist_albums GET  /api/v1/artists/:artist_id/albums(.:format)                                              api/v1/albums#index
#            api_v1_artists GET  /api/v1/artists(.:format)                                                                api/v1/artists#index
#                    api_v1 GET  /api/v1/genres/:genre_name/random_song(.:format)                                         api/v1/songs#random
#          auth_login_admin POST /auth/login_admin(.:format)                                                              authentication#authenticate_admin
#              signup_admin POST /signup/admin(.:format)                                                                  users#create_admin
#        rails_service_blob GET  /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET  /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET  /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT  /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, constraints: ApiVersion.new('v1', true) do
    namespace :v1 do
      resources :artists, only: [:index] do
        resources :albums, only: [:index], shallow: true do
          resources :songs, only: [:index]
        end
      end
      get 'genres/:genre_name/random_song', to: 'songs#random'
    end
  end
  post 'auth/login_admin', to: 'authentication#authenticate_admin'
  post 'signup/admin', to: 'users#create_admin'
end
