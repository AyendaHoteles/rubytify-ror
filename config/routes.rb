Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :artists, only: :index do
        resources :albums, only: :index #For each artist, we want to display all their albums
      end

      resources :albums , only: :index do
        resources :songs, only: :index #For each album, we want to display all its songs
      end


      get 'genres/:genre_name/random_song', to: 'genres#sample'
    end
  end
end
