require 'rails_helper'

RSpec.describe "Artists", type: :request do
  scenario 'GET /api/v1/artists returns the correct data and format' do
    get api_v1_artists_url
    expect(response).to have_http_status "200"
  end
end
