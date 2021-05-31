require 'rails_helper'

RSpec.describe 'Artists', type: :request do
  
   it 'returns all Artists' do
      get '/api/v1/artists'
      expect(response).to have_http_status(:success)
   end
   
   it 'returns valid JSON' do
   
      artist = Artist.create(name: 'Dummy', popularity: 8, spotify_url: "https://spotify.com", spotify_id: 345)
      artist2 = Artist.create(name: 'Dummy 2', popularity: 8, spotify_url: "https://spotify.com", spotify_id: 678)
      
      get '/api/v1/artists'
      
      body = JSON.parse(response.body)
      expect(body['data'].length).to eq(2)
   end
end