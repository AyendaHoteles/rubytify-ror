require 'rails_helper'

RSpec.describe 'Artists', type: :request do
  before(:each) do
    @artists = create_list(:artist, 10)
  end

  describe 'GET /api/v1/artists' do
    it 'should return all artists' do
      get '/api/v1/artists'
      payload = JSON.parse(response.body)
      expect(payload['data'].size).to eq(10)
      expect(response).to have_http_status(200)
    end
  end
end
