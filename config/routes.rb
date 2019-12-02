Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :artists, only: [:index] do
        resources :albums, only: [:index]
      end
      get '/albums/:id/songs' => 'songs#index'
      get '/genres/:genre_name/random_song' => 'songs#random_song'
    end
  end
end
