Rails.application.routes.draw do
  resources :tracks
  resources :songs
  resources :albums
  resources :artists
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :artists    
    end 
  end 

  get '/api/v1/artists/:id/albums', to: 'albums#show'  

  get '/api/v1/albums/:id/songs', to: 'tracks#show'

  get '/api/v1/genres/:genre_name/random_song', to: 'tracks#random'
end
