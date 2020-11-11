Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    
  
    namespace :api do
      namespace :v1 do
        resources :artists, only: %i[index] do
          get :albums, on: :member
        end
        resources :albums, only: [] do
          get :songs, on: :member
        end
        get '/genres/:genre_name/random_song' => 'songs#random_song'
        # health check endpoint
        get '/health', to: lambda {|_| [200, { 'Content-Type' => 'application/json' }, [{ status: "ok" }.to_json] ] }
      end
    end
end
