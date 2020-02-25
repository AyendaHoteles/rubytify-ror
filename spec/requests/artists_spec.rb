# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe 'Artists API', type: :request do
  describe 'GET /api/v1/artists' do
    let(:request) { get '/api/v1/artists' }
    let(:artists) { create_list(:artist, 20) }

    before { request }

    context 'with success response' do
      it 'returns status ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with records' do
      it 'returns all records' do
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq Artist.count
      end
    end
  end
end
