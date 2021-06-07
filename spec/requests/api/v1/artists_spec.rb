require 'rails_helper'

RSpec.describe 'Artists', type: :request do
  describe 'GET /api/v1/artists' do
    #artist = Artist.create(name: 'Kurt', popularity: 12, spotify_url: 'urlspotify.com/gg45ft4y5tfty4', spotify_id: 'gg45ft4y5tfty4')
    #artist2 = Artist.create(name: 'Bobby', popularity: 56, spotify_url: 'urlspotify.com/877gdffgf7g7df76', spotify_id: '877gdffgf7g7df76')
    #let(:artist) { create_list(:artist, 4) }
    it 'should return all artists' do
      get '/api/v1/artists'
      payload = JSON.parse(response.body)
      #expect(payload.size).to eq(2)
      expect(response).to have_http_status(200)
    end
  end

end
