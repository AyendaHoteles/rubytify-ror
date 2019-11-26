Rails.application.routes.draw do
  api_version(module: 'api/v1', path: { value: 'api/v1' }, defaults: { format: :json }) do
    resources :artists, only: :index do
      resources :albums, only: :index 
    end

    resources :albums, only: :index do
      resources :songs, only: :index
    end

    resources :genres, params: :genre_name, only: :index  do
      resources :random_song, only: :index do
      end
    end
  end 
end
