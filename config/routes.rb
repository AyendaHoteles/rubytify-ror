Rails.application.routes.draw do
   namespace :api do
      namespace :v1 do
         resources :artists do
            resources :albums
         end
         resources :albums do
            resources :songs
         end
      end
   end
end
