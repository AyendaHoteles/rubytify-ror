Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #api
  namespace :api do
    namespace :v1 do
      resources :artists, only: [:index] do
      	resources :albums, only: [:index]
      end
      resources :albums, only: [:index] do
      	resources :songs, only: [:index]
      end
      resources :genres, only: [:index], param: :name do
      	resource :songs, only: [:index] do
          get :random_song, on: :collection
        end
      end
    end
  end
end
