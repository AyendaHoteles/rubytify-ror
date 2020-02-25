# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # API -----------------------
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :artists, only: :index do
        resources :albums, only: :index
      end

      resources :albums, only: [], path: 'albums' do
        resources :songs, only: :index
      end

      resources :genres, only: :index, path: 'genres/:genre_name/random_song'
    end
  end
end
