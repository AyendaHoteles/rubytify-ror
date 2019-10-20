require 'rails_helper'

describe 'GET /api/v1/genres/:genre_name/random_song' do
  let(:artist1) { create(:artist, name: 'Rock Artist', genres: ['rock', 'indie rock']) }
  let(:artist2) { create(:artist, name: 'Pop Artist', genres: ['pop']) }
  let!(:album1) { create(:album, name: 'Album Artist One', artist: artist1) }
  let!(:album2) { create(:album, name: 'Album Artist Two', artist: artist2) }
  let!(:song1) { create(:song, name: 'Rock Song', album: album1) }
  let!(:song2) { create(:song, name: 'Pop Song', album: album2) }

  it 'return all artists ordered by their popularity' do
    genre = 'rock'
    get "/api/v1/genres/#{genre}/random_song"

    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['data']['name']).to eq('Rock Song')
    expect(JSON.parse(response.body)['data']['spotify_url']).to eq(song1.spotify_url)
    expect(JSON.parse(response.body)['data']['preview_url']).to eq(song1.preview_url)
    expect(JSON.parse(response.body)['data']['duration_ms']).to eq(song1.duration_ms)
    expect(JSON.parse(response.body)['data']['explicit']).to eq(song1.explicit)
  end
end
