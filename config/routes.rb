Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :artists, only: :index do
        resources :albums, only: :index
      end
      # routes [resources :albums] are not in the specification
      get 'albums/:album_id/songs', to: 'songs#index'
      get 'genres/:genre_name/random_song', to: 'songs#show_random'
    end
  end
end
