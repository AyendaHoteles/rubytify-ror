# frozen_string_literal: true

Rails.application.routes.draw do
  defaults format: :json do
    namespace :api do
      namespace :v1 do
        resources :artists, only: %i[index]
      end
    end
  end
end
