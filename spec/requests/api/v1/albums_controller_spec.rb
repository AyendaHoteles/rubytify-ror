# frozen_string_literal: true

require 'rails_helper'
require 'database_cleaner'

RSpec.describe 'artist API', type: :request do
  describe 'get api/v1/artists/:artists_id/albums' do
    let!(:user) { create(:admin_user) }
    let(:header) { valid_headers }
    let(:invalid_header) { { 'Authorization': nil } }
    context 'when request is valid ' do
      before do
        artist = create(:artist)
        create_list(:album, 10, artist_id: artist.id)
        get "/api/v1/artists/#{artist.id}/albums", headers: header
      end
      it 'return valid code' do
        expect(response).to have_http_status(200)
      end

      it 'return data key in response' do
        expect(JSON.parse(response.body)).to have_key('data')
      end

      it 'return 10 albums' do
        expect(JSON.parse(response.body)['data'].length).to eq(10)
      end

      it 'return valid album' do
        expect(JSON.parse(response.body)['data'][0]).to have_key('name')
        expect(JSON.parse(response.body)['data'][0]).to have_key('image')
        expect(JSON.parse(response.body)['data'][0]).to have_key('total_tracks')
        expect(JSON.parse(response.body)['data'][0]).to have_key('spotify_url')
        expect(JSON.parse(response.body)['data'][0]).to have_key('spotify_id')
      end
    end
    context 'when request is invalid ' do
      before do
        artist = create(:artist)
        create_list(:album, 10, artist_id: artist.id)
        get "/api/v1/artists/#{artist.id}/albums", headers: invalid_header
      end
      it 'return valid code' do
        expect(response).to have_http_status(422)
      end
    end
    context 'when artist does not exist' do
      before do
        get '/api/v1/artists/1/albums', headers: header
      end
      it 'return valid code' do
        expect(response).to have_http_status(404)
      end
    end
  end
end