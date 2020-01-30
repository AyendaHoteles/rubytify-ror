require 'rails_helper'

RSpec.describe "GET /api/v1/albums/:album_id/songs", type: :request do
  before do
    @artist = Artist.create!(
      spotify_id: '7Ln80lUS6He07XvHI8qqH'
    )
    @album = Album.create!(
      spotify_id: '7v6FNgLDS8KmaWA1amUtqe',
      artist: @artist
    )
    @song = Song.create!(
      name: 'Test Song',
      album: @album
    )
  end

  scenario 'returns the correct data, order and format' do
    get api_v1_album_songs_url(@album)
    expect(response).to have_http_status '200'
    json_valid_object = {
      data: [{
        name: @song.name,
        spotify_url: @song.spotify_url,
        preview_url: @song.preview_url,
        duration_ms: @song.duration_ms,
        explicit: @song.explicit
      }]
    }
    expect(response.body).to eq json_valid_object.to_json
  end

  scenario 'returns 404 if an albums id does not existis' do
    get api_v1_album_songs_url(album_id: 100_000)
    expect(response).to have_http_status '404'
  end
end
