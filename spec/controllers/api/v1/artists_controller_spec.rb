require 'rails_helper'

RSpec.describe Api::V1::ArtistsController, type: :controller do
  fixtures :artists

  let(:output) do
    load_json_symbolized('outputs/artists.json')
  end

  describe 'routes to the artists controller' do
    it 'routes to #index' do
      expect({get: 'api/v1/artists'}).
        to route_to(
          controller: 'api/v1/artists',
          action: 'index'
        )
    end
  end

  describe 'GET to #index' do
    before {
      get :index
    }

    it { expect(response.status).to eq(200) }
    it { expect(json['data']).to_not be_empty }
    it { expect(JSON.parse(response.body, symbolize_names: true)).to eq(output) }
  end
end
