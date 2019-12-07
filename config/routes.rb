Rails.application.routes.draw do
  namespace :api do
  	namespace :v1 do
      resources :songs
      
      resources :albums

      resources :artists
      get '/artists/:id/albums', to: 'artists#albums', as: 'get_albums'
      get '/albums/:id/songs', to: 'albums#songs', as: 'get_songs'
      get '/genres/:genre_name/random_song', to: 'songs#random_song', as: 'random_song'

    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
