require 'rails_helper'

RSpec.describe Api::V1::SongsController, type: :request do
  let!(:song) { create(:song) }

  it 'success' do
    genre_name = URI.encode(song.album.artist.genres.first.name)
    get "/api/v1/genres/#{genre_name}/random_song"
    expect(response.status).to eq(200)
    json = JSON.parse(response.body) 
    data = json['data']
    expect(data['spotify_url']).not_to be(nil)
    expect(data['duration_ms']).not_to be(nil)
    expect(data['id']).not_to be(nil)
    expect(data['preview_url']).not_to be(nil)
    expect(data['explicit']).not_to be(nil)
  end

  it 'return message when not register genre' do
    genre_name = URI.encode('not a genre')
    get "/api/v1/genres/#{genre_name}/random_song"
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    data = json['data']
    expect(data['message']).to eq('Not register genre')
  end
end
