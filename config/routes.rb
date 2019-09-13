Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'artists', to: 'artists#index'
      get 'artists/:id/albums', to: 'artists#show'
      get 'albums/:id/songs', to: 'albums#show'
      get 'genres/:genre_name/random_song', to: 'genres#show'
    end
  end
end
