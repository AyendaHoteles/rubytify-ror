Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :articles
      resources :albums do
        collection do
          get '/:id/songs', to: 'albums#songs_album', as: :songs_single_album
        end
      end
      resources :artists do
        collection do
          get :find_artist
          get :index
          get '/:id/albums', to: 'artists#artist_albums', as: :albums_single_artist
        end
      end
      resources :genres do
        collection do
          get '/:genre_name/random_song', to: 'genres#random_song', as: :random_song
        end
      end
      resources :tracks do
        collection do
          get :top_100
        end
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
