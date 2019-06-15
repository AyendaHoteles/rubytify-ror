Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/artists', to: 'artists#artists'
      get '/artists/:id/albums', to: 'albums#albums'
      get '/albums/:id/songs', to: 'songs#songs'
      get '/genres/:genre_name/random_song', to: 'songs#random_song'
    end
  end

end
