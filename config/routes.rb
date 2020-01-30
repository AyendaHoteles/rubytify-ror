Rails.application.routes.draw do
  require 'sidekiq/web'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :artists, only: :index do
        resources :albums, only: :index, shallow: true do
          resources :songs, only: :index
        end
      end
      match '*unmatched', to: 'base#bad_request', via: :all
    end
  end
  mount Sidekiq::Web => '/sidekiq'
end
