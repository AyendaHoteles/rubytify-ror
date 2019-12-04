Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
     get 'genres/:genre_name/random_song' =>'genres#random_song'
      resources :artists do
        collection do
          get :index
          get ':id/albums' =>'artists#albums'
          #get ':id/cierre' => 'cuadres#cierre', as: :cierre
        end
      end
      resources :songs do
        collection do
          get :index
         
        end
      end
      resources :albums do
        collection do
          get :index
          get ':id/songs' =>'albums#songs'
         
        end
      end
    end
  end
end
