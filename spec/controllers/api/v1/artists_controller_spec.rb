require 'rails_helper'
RSpec.describe Api::V1::ArtistsController do
  describe "GET #index" do
    let!(:artists) {FactoryBot.create_list(:random_artist, 20)}
    before do
      get :index
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "JSON body response contains expected format" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(["data"])
    end

    it 'returns all artists' do
      expect(JSON.parse(response.body)['data'].size).to eq(20)
    end
  end


end
