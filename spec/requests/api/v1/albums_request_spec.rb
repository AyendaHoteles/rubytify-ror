require 'rails_helper'

RSpec.describe "GET /api/v1/artists/:artist_id/albums", type: :request do
  fixtures :artists, :albums

  scenario 'returns the correct data, order and format' do
    artist = artists(:artist_1)
    get api_v1_artist_albums_url(artist)
    expect(response).to have_http_status '200'
    json_valid_object = {
      data: artist.albums
                  .select('id, name, image, spotify_url, total_tracks')
    }
    expect(response.body).to eq json_valid_object.to_json
  end

  scenario 'returns 404 if an artist id does not existis' do
    get api_v1_artist_albums_url(artist_id: 100_000)
    expect(response).to have_http_status '404'
  end
end
