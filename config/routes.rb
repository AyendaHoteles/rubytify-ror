Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace "api" do
    namespace "v1" do
      resources :artists, only: [:index] 
#        resources :albums, only: [:index]
      get "artists/:id/albums", to: "artists#albums"

      get "albums/:id/songs", to: "albums#songs" 
      get "genres/:genre_name/random_song", to: "songs#random"
    end
  end
end