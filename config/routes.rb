Rails.application.routes.draw do
  api_version(:module => "api/v1", :path => {:value => "api/v1"}) do
    resources :artists, only: [:index] do
      member do
        get :albums
      end
    end

    resources :albums, only: [] do
      member do
        get :songs
      end
    end

    get "/genres/:genre_name/random_song", to: "genres#random_song"
  end
end
