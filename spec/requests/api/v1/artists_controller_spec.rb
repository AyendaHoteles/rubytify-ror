# frozen_string_literal: true

require 'rails_helper'
require 'database_cleaner'

RSpec.describe 'artist API', type: :request do
  describe 'get api/v1/artists' do
    let!(:user) { create(:admin_user) }
    let(:header) { valid_headers }
    let(:invalid_header) { { 'Authorization': nil } }
    context 'when request is valid ' do
      before do
        create_list(:artist, 10)
        get '/api/v1/artists', headers: header
      end
      it 'return valid code' do
        expect(response).to have_http_status(200)
      end

      it 'return data key in response' do
        expect(JSON.parse(response.body)).to have_key('data')
      end

      it 'return 10 artists' do
        expect(JSON.parse(response.body)['data'].length).to eq(10)
      end

      it 'return valid artist' do
        expect(JSON.parse(response.body)['data'][0]).to have_key('name')
        expect(JSON.parse(response.body)['data'][0]).to have_key('image')
        expect(JSON.parse(response.body)['data'][0]).to have_key('genres')
        expect(JSON.parse(response.body)['data'][0]).to have_key('popularity')
        expect(JSON.parse(response.body)['data'][0]).to have_key('spotify_url')
        expect(JSON.parse(response.body)['data'][0]).to have_key('spotify_id')
      end
    end
    context 'when request is invalid ' do
      before do
        get '/api/v1/artists', headers: invalid_header
      end
      it 'return valid code' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
