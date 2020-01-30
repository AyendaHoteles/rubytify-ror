Rails.application.routes.draw do
  require "sidekiq/web"
  mount Sidekiq::Web => '/sidekiq'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :artists, only: :index
    end
  end
end
