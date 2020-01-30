require 'rails_helper'

RSpec.describe "GET /api/v1/artists", type: :request do
  fixtures :artists

  scenario 'returns the correct data, order and format' do
    get api_v1_artists_url
    expect(response).to have_http_status '200'
    json_valid_object = {
      data: Artist.select('id, name, image, genres, popularity, spotify_url')
                  .order(popularity: :desc)
                  .all
    }
    expect(response.body).to eq json_valid_object.to_json
  end
end
