require 'rails_helper'

RSpec.describe Api::V1::ArtistsController do
  describe 'GET #index' do
    before do
      get '/api/v1/artists'
    end
    
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    
  end
end