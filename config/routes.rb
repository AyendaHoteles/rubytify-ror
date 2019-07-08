Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :artists, only: [:index] do
        resources :albums, only: [:index]
      end

      resources :albums, only: [] do
        member do
          get 'songs', to: 'songs#index'
        end
      end
    end
  end
end