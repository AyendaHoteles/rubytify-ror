require 'rails_helper'
require 'byebug'

RSpec.describe Api::V1::AlbumsController, type: :controller do
  context 'Get Song by album #songs_by_album' do
    before(:each) do
      FactoryBot.create(:album)
    end

    it "album don't exist" do
      get :songs_by_album, params: {id: 153}
      expect(response).to have_http_status(:not_found)
    end

    it 'return songs' do
      get :songs_by_album, params: {id: 1}
      expect(response).to have_http_status(:success)
    end
  end
end