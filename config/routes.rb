Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get ':genre_name/random_song', to: "songs#random_song"
      resources :artists, only: [:index, :show] do
        member do
          get 'albums'
        end
      end
      resources :albums, only: [:index, :show] do
        member do
          get 'songs'
        end
      end
    end
  end
end
