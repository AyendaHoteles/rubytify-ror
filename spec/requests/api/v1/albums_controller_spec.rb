require 'rails_helper'

RSpec.describe Api::V1::AlbumsController, type: :request do
  let!(:album) { create(:album) }

  it 'success' do
    get "/api/v1/artists/#{album.artist.id}/albums"
    expect(response.status).to eq(200)
    json = JSON.parse(response.body) 
    expect(json['data'].count).to eq(1)
    json_album = json['data'][0]
    expect(json_album['name']).to eq(album.name)
    expect(json_album['spotify_url']).to eq(album.spotify_url)
    expect(json_album['spotify_id']).to eq(nil)
    expect(json_album['total_tracks']).to eq(album.total_tracks)
  end
end
