require 'rails_helper'

describe Api::V1::AlbumsController do
  describe 'GET #index' do
    subject(:http_request) do
      get :index, params: { artist_id: artist.id }
    end

    let(:artist) { Artist.last }
    let(:song) { create_list(:song, 3) }

    before do
      song
      http_request
    end

    it 'responds with ok status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'validat count response' do
      expect(JSON(response.body)['data'].count).to be artist.albums.count
    end
  end
end
