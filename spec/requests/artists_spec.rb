require 'rails_helper'

RSpec.describe 'Artists API', type: :request do
  # initialize test data
  let!(:artists) { create_list(:artist, 10) }
  let(:artist_id) { artists.first.id }

  # Test suite for GET /artists
  describe 'GET /api/v1/artists' do
    # make HTTP get request before each example
    before { get '/api/v1/artists' }

    it 'returns artists' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

end
