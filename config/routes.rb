Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  #

  # Api
  namespace :api do # Dont put format constraint to json yet, should migrate crm endpoints first
    namespace :v1, constraints: {format: 'json'} do

      get '/artists' => 'artists#index'
      get '/artists/:id/albums' => 'artists#get_albums'
      get '/albums/:id/songs' => 'albums#get_songs'
      get '/genres/:genre_name/random_song' => 'songs#random_song_genre'

    end

  end

end
