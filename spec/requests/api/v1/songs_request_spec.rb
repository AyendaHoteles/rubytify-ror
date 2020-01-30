require 'rails_helper'

RSpec.describe "Songs Controller", type: :request do
  fixtures :artists, :albums, :songs

  context "GET /api/v1/albums/:album_id/songs" do
    scenario 'returns the correct data, order and format' do
      album = albums(:album_1)
      song = songs(:song_1)
      get api_v1_album_songs_url(album)
      expect(response).to have_http_status '200'
      json_valid_object = {
        data: [{
          name: song.name,
          spotify_url: song.spotify_url,
          preview_url: song.preview_url,
          duration_ms: song.duration_ms,
          explicit: song.explicit
        }]
      }
      expect(response.body).to eq json_valid_object.to_json
    end

    scenario 'returns 404 if an albums id does not existis' do
      get api_v1_album_songs_url(album_id: 100_000)
      expect(response).to have_http_status '404'
    end
  end

  context "GET /api/v1/genres/:genre_name/random_song" do
    scenario 'returns the correct data, order and format' do
      get api_v1_random_song_url('vallenato')
      expect(response).to have_http_status '200'
      song_name = JSON.parse(response.body)['data']['name']
      expect(['Vallenato 1', 'Vallenato 2']).to include(song_name)
    end
  end
end
