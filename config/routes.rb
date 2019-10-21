Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'artists#index'

  scope :api, defaults: {format: :json} do
    get 'v1/artists', to: 'artists#index'
    get 'v1/artists/:id/albums', to: 'artists#albums'
    get 'v1/albums/:id/songs', to: 'albums#songs'
    get 'v1/genres/:genre_name/random_song', to: 'genres#random_song'
  end
end
