Rails.application.routes.draw do
  root "welcome#index"
  get 'api/v1/artists', to: 'artists#index'
  get 'api/v1/artists/:id/albums', to: 'artists#albums'
  get 'api/v1/albums/:id/songs', to: 'albums#songs'
  get 'api/v1/genres/:genre_name/random_song', to: 'genres#random_song'
end
