Rails.application.routes.draw do
  get '/heartbeat', to: lambda {|_| [200, { 'Content-Type' => 'application/json' }, [{ status: "ok" }.to_json] ] }

  get '/api/v1/artists' => 'artists#index'
end
