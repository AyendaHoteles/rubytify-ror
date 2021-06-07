Rails.application.routes.draw do
  get '/health', to: 'health#health'

  namespace :api do
    namespace :v1 do
      resources :artists, only: [:index] do
        resources :albums, only: [:index]
      end
      resources :albums do
        resources :songs, only: [:index]
      end
      get '/genres/:genre_name/random_song', to: 'songs#random_song'
    end
  end

end
