# frozen_string_literal: true

Rails.application.routes.draw do
  defaults format: :json do
    namespace :api do
      namespace :v1 do
        resources :artists, only: %i[index] do
          resources :albums, only: %i[index]
        end

        resources :albums, only: %i[] do
          resources :songs, only: %i[index]
        end

        resources :genres, param: :genre_name, only: %i[] do
          member do
            get :random_song
          end
        end
      end
    end
  end
end
