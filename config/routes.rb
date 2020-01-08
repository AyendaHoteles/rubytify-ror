Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :artists, only: %i(index) do
        member do
          resources :albums, only: %i(index)
        end
      end
      resources :albums, only: [] do
        member do
          resources :songs, only: %i(index)
        end
      end
      resources :genres, param: :name, only: [] do
        get :random_song
      end
    end
  end
end
