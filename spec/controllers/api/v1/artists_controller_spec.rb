require 'rails_helper'

describe Api::V1::ArtistsController do
  describe 'GET #index' do
    subject(:http_request) { get :index }

    let(:song) { create_list(:song, 3) }

    before do
      song
      http_request
    end

    it 'responds with ok status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'validat count response' do
      expect(JSON(response.body)['data'].count).to be Artist.all.count
    end
  end
end
