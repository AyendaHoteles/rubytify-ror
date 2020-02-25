# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe 'Songs API', type: :request do
  describe 'GET /api/v1/albums/:album_id/songs' do
    let(:album) { create(:album) }
    let(:songs) { create_list(:song, 10, album_id: album.id)}
    let(:request) { get "/api/v1/albums/#{album.id}/songs" }

    before { request }

    context 'with success response' do
      it 'returns status ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with records' do
      it 'returns all records' do
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq Song.count
      end
    end
  end
end