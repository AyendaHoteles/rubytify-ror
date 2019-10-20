require 'rails_helper'

RSpec.describe Api::V1::ArtistsController, type: :request do
  let!(:artist0) { create(:artist) }
  let!(:artist1) { create(:artist, name: 'New Artist') }

  it 'success' do
    get '/api/v1/artists'
    expect(response.status).to eq(200)
    json = JSON.parse(response.body) 
    expect(json['data'].count).to eq(2)
    json_artist = json['data'][0]
    expect(json_artist['name']).to eq(artist0.name)
    expect(json_artist['spotify_url']).to eq(artist0.spotify_url)
    expect(json_artist['spotify_id']).to eq(nil)
    expect(json_artist['popularity']).to eq(artist0.popularity)
  end
end
