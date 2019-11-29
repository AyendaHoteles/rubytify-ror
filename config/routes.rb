Rails.application.routes.draw do

  scope 'api' do
    scope 'v1' do
      resources :artists, only: [:index]
      resources :artists, only: [:index] do
        resources :albums, only: [:index]
      end
      resources :albums, only: [:index] do
        resources :songs, only: [:index] 
      end
    end
  end

end
