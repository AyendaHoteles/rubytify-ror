Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'artists', to: 'artists#index'
      get 'artists/:id/albums', to: 'albums#index'
      get 'albums/:id/songs', to: 'songs#index'
      get 'genres/:genre_name/random_song', to: 'genders#index'
    end
  end
end
