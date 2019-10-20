require 'rails_helper'

describe 'GET /api/v1/albums/:id/songs' do
  let(:artist) { create(:artist) }
  let!(:album) { create(:album, artist: artist) }
  let!(:song) { create(:song, album: album) }

  it 'returns all artists ordered by their popularity' do
    get "/api/v1/albums/#{album.id}/songs"

    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['data'][0]['name']).to eq(song.name)
    expect(JSON.parse(response.body)['data'][0]['spotify_url']).to eq(song.spotify_url)
    expect(JSON.parse(response.body)['data'][0]['preview_url']).to eq(song.preview_url)
    expect(JSON.parse(response.body)['data'][0]['duration_ms']).to eq(song.duration_ms)
    expect(JSON.parse(response.body)['data'][0]['explicit']).to eq(song.explicit)
  end
end
