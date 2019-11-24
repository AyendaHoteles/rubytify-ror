Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :artists, only: :index do
        resources :albums, only: :index
      end
      
      get 'albums/:id/songs', to: 'songs#index'
      get 'genres/:genre_name/random_song', to: 'songs#random'
    end
  end
end
