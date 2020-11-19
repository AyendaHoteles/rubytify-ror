Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      get '/artists', to: 'artists#index', as: :artists
      get '/artists/:id/albums', to: 'artists#albums_by_artist', as: :albums_by_artist
      get '/albums', to: 'albums#index', as: :albums
      get '/albums/:id/songs', to: 'albums#songs_by_album', as: :songs_by_album
      get '/genres/:genre_name/random_song', to: 'genres#aleatory_song_by_gender', as: :songs_by_genre
    end
  end
end
