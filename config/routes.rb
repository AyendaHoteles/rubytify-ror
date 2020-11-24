Rails.application.routes.draw do
  root 'home#index'
  namespace :api do
    namespace :v1 do
      
      resources :artists do
        resources :albums
      end
      
      resources :albums do  
        resources :songs
      end
      
      get 'genres/:genre_name/random_song', to: 'songs#random_song'

    end  
  end

  get '*path', to: 'pages#index', via: :all
end
