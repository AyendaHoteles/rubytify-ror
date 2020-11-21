Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "welcome#index"
  namespace "api" do
    namespace "v1" do
      resources :artists, only: [:index] 

      get "artists/:id/albums", to: "artists#albums"

      get "albums", to: "albums#index"
      get "albums/:id/songs", to: "albums#songs" 
      get "genres/:genre_name/random_song", to: "songs#random_song"
    end
  end
end
