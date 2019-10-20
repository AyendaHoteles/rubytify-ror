require 'rails_helper'

RSpec.describe Api::V1::SongsController, type: :request do
  let!(:song) { create(:song) }

  it 'success' do
    get "/api/v1/albums/#{song.album.id}/songs"
    expect(response.status).to eq(200)
    json = JSON.parse(response.body) 
    expect(json['data'].count).to eq(1)
    json_song = json['data'][0]
    expect(json_song['name']).to eq(nil)
    expect(json_song['spotify_url']).to eq(song.spotify_url)
    expect(json_song['spotify_id']).to eq(nil)
    expect(json_song['duration_ms']).to eq(song.duration_ms)
  end
end
