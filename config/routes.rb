Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "api/v1/artists#index"

  namespace :api do
    namespace :v1 do
      scope 'albums/:id' do
        resources :songs, defaults: { format: :json }, only: [:index]
      end
      scope 'artists/:id' do
        resources :albums, defaults: { format: :json }, only: [:index]
      end
      resources :artists, defaults: { format: :json }, only: [:index]
    end
  end
end
