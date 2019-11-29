Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :artists do
        resources :albums do
          resources :songs
        end
 
      end

      resources :albums do
        resources :songs, only: [:index]
      end

      resources :genres, only: [:show] do
        resources :songs, only: [:index]
      end
    end
  end
end
