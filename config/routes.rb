Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :artists, only: [:index] do
        resources :albums, only: [:index]
      end
      resources :albums, only: [:index] do
        resources :songs, only: [:index]
      end
      get '/genres/:genre_name/random_song', to: "random_song#show_song" 
    end
  end
end
