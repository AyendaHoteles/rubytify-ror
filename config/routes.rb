Rails.application.routes.draw do
  root to: 'api/v1/artists#index'
  namespace :api do
    namespace :v1 do
      resources :albums, only: [] do
        resources :songs, only: [:index], defaults: { format: :json }
      end
      resources :artists, only: [:index], defaults: { format: :json } do
        get '/albums', defaults: { format: :json }, to: 'artists#albums'
      end
      get 'genres/:genre_name/random_song', defaults: { format: :json },
                                            to: 'songs#random_song',
                                            as: :genre_random_song
    end
  end
end
