require 'rails_helper'

RSpec.describe API::V1::Albums do
  include Rack::Test::Methods

  def app
    API::V1::Albums
  end

  let(:json) { last_response.body }

  context 'GET /api/v1/albums/{id}/songs' do
    let!(:artist) { create(:artist) }
    let!(:album) { create(:album, artist: artist) }
    let!(:songs) { create_list(:song, 5, artist: artist, album: album) }

    let(:parsed_json) { JSON.parse(json) }

    describe 'on Success' do
      before do
        get "/v1/albums/#{album.id}/songs"
        json
      end

      it 'returns a 200 code' do
        expect(last_response.status).to eq(200)
      end

      it 'include the songs' do
        expect(json).to have_json_path('data/0/name')
      end

      it 'returns all the songs' do
        expect(parsed_json['data'].count).to eq(5)
      end
    end

    describe 'on Failure' do
      before do
        get '/v1/albums/0/songs'
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
