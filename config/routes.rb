Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api, defaults: {format: :json} do
    get 'v1/artists', to: 'artists#index'
    get 'v1/artists/:id/albums', to: 'artists#show'
    get 'v1/albums/:id/songs', to: 'albums#show'
  end
end
