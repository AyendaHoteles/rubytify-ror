Rails.application.routes.draw do
  root to: "artists#index"
  # Api Routes endpoints
  namespace :api do
    namespace :v1 do
      get 'artists', to: 'artists#index'
      get 'artists/:id/albums', to: 'artists#show'
      get 'albums/:id/songs', to: 'albums#show'
      get 'genres/:genre_name/random_song', to: 'genres#show'
    end
  end
  # test routes
  get 'artists', to: 'artists#index'
  get 'artists/:id/albums', to: 'albums#index'
  get 'albums/:id/songs', to: 'songs#index'
  get 'genres/:id/random_song', to:'genres#index'
end
