Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'genres/:genre_name/random_song', to: 'songs#random'
      resources :artists, only: :index do 
        resources :albums, only: :index
      end
      resources :albums, only: [] do 
        resources :songs, only: :index
      end
    end
  end
end
#               Prefix Verb URI Pattern                                      Controller#Action
#               api_v1 GET  /api/v1/genres/:genre_name/random_song(.:format) api/v1/songs#random
# api_v1_artist_albums GET  /api/v1/artists/:artist_id/albums(.:format)      api/v1/albums#index
#       api_v1_artists GET  /api/v1/artists(.:format)                        api/v1/artists#index
#   api_v1_album_songs GET  /api/v1/albums/:album_id/songs(.:format)         api/v1/songs#index
