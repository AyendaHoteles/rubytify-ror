Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/artists', to: 'artists#index'
      get '/artists/:id/albums', to: 'albums#index'
      get '/albums/:id/songs', to: 'songs#index'
      get '/genres/:genre_name/random_song', to: 'songs#by_genre'
    end
  end
end
