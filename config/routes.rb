Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' }  do
    namespace :v1 do
      resources :artists, only: [:index] do
        resources :albums, only: [:index]
      end

      resources :albums, only: [] do
        resources :songs, only: [:index]
      end

      get 'genres/:genre_name/random_song', to: 'genres#random_song', as: 'genre_random_song'
    end
  end
end
