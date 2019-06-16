require 'rails_helper'

RSpec.describe Api::V1::Albums::SongsController, type: :controller do
  fixtures :songs

  let(:output) do
    load_json_symbolized('outputs/songs.json')
  end

  describe 'routes to the albums controller' do
    it 'routes to #index' do
      expect({get: 'api/v1/albums/1/songs'}).
        to route_to(
          album_id: '1',  
          controller: 'api/v1/albums/songs',
          action: 'index'
        )
    end
  end

  describe 'GET to #index' do
    context 'on success' do 
      before {
        get :index, params: { album_id: 20 }
      }

      it { expect(response.status).to eq(200) }
      it { expect(json['data'].count).to eq(2) }
      it { expect(JSON.parse(response.body, symbolize_names: true)).to eq(output) }
    end

    context 'on record not found' do
      before {
        get :index, params: { album_id: 22 }
      }

      it { expect(response.status).to eq(404) }
    end
  end
end
