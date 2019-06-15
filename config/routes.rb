Rails.application.routes.draw do
  #namespace :api, defaluts: {format: :json} => defaults

  namespace 'api', defaults: { format: :json } do
    namespace 'v1', defaults: { format: :json } do
      get 'artists', to: 'artists#index'
      get 'artists/:id/albums', to: 'artists#get_albums'
      get 'albums/:id/songs', to: 'albums#get_songs'
      get 'genres/:genre_name/random_song', to: 'genres#song_by_genre'
    end
  end

end
