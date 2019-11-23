Rails.application.routes.draw do
  root :to => "api/v1/artists#index"
  namespace "api" do
    namespace "v1" do
      resources :artists, only: [:index] do
        get "/:id/albums", to: "artists#albums", on: :collection, as: "artist_albums"
      end
      get "albums/:id/songs", to: "albums#songs", as: "album_songs"
      get "genres/:genre_name/random_song", to: "songs#random_song", as: "random_song"
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
