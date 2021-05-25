Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :artists, only: [:index, :albums]
      get 'artists/:id/albums', to: 'artists#albums'

      resources :albums, only: [:index, :show]
      get 'albums/:id/songs', to: 'albums#show'


      resources :songs, only: [:index, :random]
      get 'genres/:genre_name/random_song', to: 'songs#random'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
