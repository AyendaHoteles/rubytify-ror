require 'rails_helper'

RSpec.describe 'Albums', type: :request do
  describe 'GET /api/v1/artists/:id/albums' do
    it 'should return all albums from an artist' do
      get '/api/v1/artists/artist_id/albums'
      payload = JSON.parse(response.body)
      #expect(payload.size).to eq(2)
      expect(response).to have_http_status(200)
    end
  end
end
