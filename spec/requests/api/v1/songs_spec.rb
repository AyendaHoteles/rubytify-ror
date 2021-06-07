require 'rails_helper'

RSpec.describe 'Songs', type: :request do
  before(:each) do
    @album = create :album
    @songs = create_list(:song, 10, album_id: @album.id)
  end

  describe 'GET /api/v1/albums/:id/songs' do
    it 'should return all albums from an artist' do
      get "/api/v1/albums/#{@album.id}/songs"
      payload = JSON.parse(response.body)
      expect(payload['data'].size).to eq(10)
      expect(response).to have_http_status(200)
    end
  end
end
