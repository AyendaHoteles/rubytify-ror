Rails.application.routes.draw do
  get '/heartbeat', to: lambda {|_| [200, { 'Content-Type' => 'application/json' }, [{ status: "ok" }.to_json] ] }

  namespace :api do
    namespace :v1 do
      resources :artists, only: %i[index] do
        get :albums, on: :member
      end
      resources :albums, only: [] do
        get :songs, on: :member
      end
    end
  end
end
