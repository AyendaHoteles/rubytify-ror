Rails.application.routes.draw do
  get '/health', to: 'health#health'

  namespace :api do
    namespace :v1 do
      resources :artists, only: [:index]
    end
  end

end
