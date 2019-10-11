Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :artists, only: %i[index show] do
        resources :albums, only: %i[index]
      end
      resources :albums, only: %i[index show] do
        resources :songs, only: %i[index]
      end
      resources :genres, only: %i[index show] do
        member do
          get "random"
        end
      end
    end
  end
end
