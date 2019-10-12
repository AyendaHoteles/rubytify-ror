Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :artists, only: [:index] do
        resources :albums, only: :index
      end

      resources :albums, only: :index do
        resources :songs, only: :index
      end

      resources :genres,  param: :name, only: :index do 
        resources :random_song, only: :index
      end
    end
  end
end
