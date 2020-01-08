require 'rails_helper'

RSpec.describe Api::V1::ArtistsController, type: :controller do
  context 'GET #index' do
    it 'returns a success response on controller Artists' do
      get :index,
      format: :json
      response.successful?
    end

    it 'returns a type content response controller Artists' do
      get :index,
      format: :json
      expect(response.content_type).to eq("application/json")
    end

    it 'returns a status response controller Artists' do
      get :index,
      format: :json
      expect(response.status).to eq 200
    end
  end
end
