Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :artists, only: [:index, :show] do
    resources :albums, only: [:index] 
  end

  resources :albums, only: [:show] do
    resources :songs, only: [:index, :show]
  end

  get "/genres/:genre_name/random_song", to: "songs#show"
end
