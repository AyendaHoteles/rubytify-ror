Rails.application.routes.draw do
  root to: "artists#home"
  namespace :api do
    namespace :v1 do
      resources :artists, only: [:index] do
        resources :albums do
          resources :songs
        end
      end
      get '/genres/:genre_name/random_song', to: 'genres#random'
    end
  end
end
