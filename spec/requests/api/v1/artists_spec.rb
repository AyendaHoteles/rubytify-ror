require 'rails_helper'

RSpec.describe API::V1::Artists do
  include Rack::Test::Methods

  def app
    API::V1::Artists
  end

  let(:json) { last_response.body }

  context 'GET /api/v1/artists' do
    let!(:artists) { create_list(:artist, 5) }

    let(:parsed_json) { JSON.parse(json) }

    describe 'on Success' do
      before do
        get '/v1/artists'
        json
      end

      it 'returns a 200 code' do
        expect(last_response.status).to eq(200)
      end

      it 'include the artists' do
        expect(json).to have_json_path('data/0/id')
      end

      it 'returns all the artists' do
        expect(parsed_json['data'].count).to eq(5)
      end
    end
  end

  context 'GET /api/v1/artists/{id}/albums' do
    let!(:artist) { create(:artist) }
    let!(:artists) { create_list(:album, 5, artist: artist) }

    let(:parsed_json) { JSON.parse(json) }

    describe 'on Success' do
      before do
        get "/v1/artists/#{artist.id}/albums"
        json
      end

      it 'returns a 200 code' do
        expect(last_response.status).to eq(200)
      end

      it 'include the albums' do
        expect(json).to have_json_path('data/0/name')
      end

      it 'returns all the albums' do
        expect(parsed_json['data'].count).to eq(5)
      end
    end

    describe 'on Failure' do
      before do
        get '/v1/artists/0/albums'
        json
      end

      it 'returns a 404 code' do
        expect(last_response.status).to eq(404)
      end

      it 'returs an error in the message' do
        response = JSON.parse(json)
        expect(response['message']).to eq("Couldn't find a record that meet the criteria.")
      end
    end
  end
end
