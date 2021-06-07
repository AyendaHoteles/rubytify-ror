require 'rails_helper'

RSpec.describe 'Albums', type: :request do
  before(:each) do
    @artist = create :artist
    @albums = create_list(:album, 10, artist_id: @artist.id)
  end

  describe 'GET /api/v1/artists/:id/albums' do
    it 'should return all albums from an artist' do
      get "/api/v1/artists/#{@artist.id}/albums"
      payload = JSON.parse(response.body)
      expect(payload['data'].size).to eq(10)
      expect(response).to have_http_status(200)
    end
  end
end
