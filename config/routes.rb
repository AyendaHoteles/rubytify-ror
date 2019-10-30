Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :artists do
        collection do
        	get '/:id/albums', to: 'artists#albums_index', as: :albums_index_artist
        end
      end
      resources :albums do
      	collection do
      		get '/:id/songs', to: 'albums#songs_index', as: :songs_index_albums
      	end
      end

      resources :genres do
      	collection do
            	get '/:genre_name/random_song', to: 'genres#random_song'
            end
        end
    end
  end
  
  # get 'api/v1/genres/:genre_name/random_song', to: 'genres#random_song'

  # get '/api/v1/artists/:id/albums', to: 'artists#albums_index', as: :albums_index_artist
end

