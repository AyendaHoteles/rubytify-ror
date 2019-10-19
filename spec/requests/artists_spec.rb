require 'rails_helper'

describe 'GET /api/v1/artists' do
  let!(:artist) { create(:artist) }

  it 'return all artists ordered by their popularity' do
    get '/api/v1/artists'

    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['data'][0]['id']).to eq(artist.id)
    expect(JSON.parse(response.body)['data'][0]['name']).to eq(artist.name)
    expect(JSON.parse(response.body)['data'][0]['image']).to eq(artist.image)
    expect(JSON.parse(response.body)['data'][0]['genres']).to eq(artist.genres)
    expect(JSON.parse(response.body)['data'][0]['popularity']).to eq(artist.popularity)
    expect(JSON.parse(response.body)['data'][0]['spotify_url']).to eq(artist.spotify_url)
  end
end
