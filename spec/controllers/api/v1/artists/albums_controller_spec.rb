require 'rails_helper'

RSpec.describe Api::V1::Artists::AlbumsController, type: :controller do
  fixtures :albums

  let(:output) do
    load_json_symbolized('outputs/albums.json')
  end

  describe 'routes to the albums controller' do
    it 'routes to #index' do
      expect({get: 'api/v1/artists/1/albums'}).
        to route_to(
          artist_id: '1',  
          controller: 'api/v1/artists/albums',
          action: 'index'
        )
    end
  end

  describe 'GET to #index' do
    context 'on success' do 
      before {
        get :index, params: { artist_id: 1 }
      }

      it { expect(response.status).to eq(200) }
      it { expect(json['data'].count).to eq(1) }
      it { expect(JSON.parse(response.body, symbolize_names: true)).to eq(output) }
    end

    context 'on record not found' do
      before {
        get :index, params: { artist_id: 2 }
      }

      it { expect(response.status).to eq(404) }
    end
  end
end
