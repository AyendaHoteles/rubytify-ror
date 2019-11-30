Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :artists, only: [:index, :show] do
        resources :albums, only: [:index] 
 
      end

      resources :albums, only: [:show] do
        resources :songs, only: [:index, :show]
      end

      resources :genres, only: [:show] do
        resources :songs, only: [:show]
      end
    end
  end
end
