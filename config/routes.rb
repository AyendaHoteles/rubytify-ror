Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/api/v1/artists", to: "application#artists_all"
  get "/api/v1/artists/:id/albums", to: "application#artists_albums_by_id"
  get "/api/v1/albums/:id/songs", to: "application#songs_by_album"
  get "/api/v1/genres/:genre_name/random_song", to: "application#song_by_genre"
end
