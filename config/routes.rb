Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :artists, only:[:index, :show]
      resources :albums, only:[:show]
      # get 'genres/:genre_name/random_song' to: 'artists#random_song'
    end
  end
end
