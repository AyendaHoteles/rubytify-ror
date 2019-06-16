Rails.application.routes.draw do
  namespace :api do
    namespace :v1, path: 'v1' do
      resources :artists, only: [:index] do
        resources :albums, only: [:index], controller: 'artists/albums'
      end
      
      resources :albums, only: [] do 
        resources :songs, only: [:index], controller: 'albums/songs'
      end

      resources :genres, only: [], param: :name do
        resources :random_song, only: [:index], controller: 'genres/songs'
      end
    end
  end
end
