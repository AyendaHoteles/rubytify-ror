require 'rails_helper'

describe Api::V1::SongsController do
  describe 'GET #index' do
    subject(:http_request) do
      get :index, params: { album_id: album.id }
    end

    let(:album) { Artist.last.albums.last }
    let(:song) { create_list(:song, 3) }

    before do
      song
      http_request
    end

    it 'responds with ok status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'validat count response' do
      expect(JSON(response.body)['data'].count).to be album.songs.count
    end
  end
end
