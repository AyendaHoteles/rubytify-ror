# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe 'Albums API', type: :request do
  describe 'GET /api/v1/artists/:artist_id/albums' do
    let(:artist) { create(:artist) }
    let(:albums) { create_list(:album, 10, artist_id: artist.id)}
    let(:request) { get "/api/v1/artists/#{artist.id}/albums" }

    before { request }

    context 'with success response' do
      it 'returns status ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with records' do
      it 'returns all records' do
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq Album.count
      end
    end
  end
end
