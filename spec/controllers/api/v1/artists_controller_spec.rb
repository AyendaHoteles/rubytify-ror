require 'rails_helper'
require 'byebug'

RSpec.describe Api::V1::ArtistsController, type: :controller do
  context 'Get artists #index' do
    before(:each) do
      FactoryBot.create_list(:artist, 5)
    end
    it 'return artists' do
      get :index, params: {}
      expect(response).to have_http_status(:success)
    end
  end

  context 'Get albums by artist #albums_by_artist' do
    before(:each) do
      FactoryBot.create(:artist)
    end

    it "artist don't exist" do
      get :albums_by_artist, params: {id: 125}
      expect(response).to have_http_status(:not_found)
    end

    it 'return albums' do
      get :albums_by_artist, params: {id: 1}
      expect(response).to have_http_status(:success)
    end
  end
end