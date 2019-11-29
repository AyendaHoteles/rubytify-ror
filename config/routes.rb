Rails.application.routes.draw do

  scope 'api' do
    scope 'v1' do
      resources :artists, only: [:index]
      resources :artists, only: [:index] do
        resources :albums, only: [:index]
      end
      resources :albums, only: [:index] do
        resources :songs, only: [:index] 
      end
      match 'genres/:genre_name/random_song' => 'songs#random_song', :via => :get
    end
  end

end
