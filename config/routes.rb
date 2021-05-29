Rails.application.routes.draw do
   namespace :api do
      namespace :v1 do
         resources :artists, only: [:index] do
            resources :albums, only: [:index]
         end
         resources :albums, only: [] do
            resources :songs, only: [:index]
         end
      end
   end
end
