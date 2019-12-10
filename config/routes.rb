Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :artists, only: [:index] do
        resources :albums, only: [:index], shallow: true do
          resources :songs, only: [:index]
        end
      end
      resources :genres do
        member do
          get "random_song"
        end
      end
    end
  end
end
