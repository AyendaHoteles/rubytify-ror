require 'rails_helper'
require 'spec_helper'

RSpec.describe Api::V1::ArtistsController, type: :controller do
    fixtures :artists
    render_views

  let(:output) do
  {
    data:[
     { id: 3, name: "Pantera", image: "http", genres: "genres", popularity:"30", spotify_url: "url" },
     { id: 2, name: "Jorge Veloza", image: "http", genres: "genres", popularity:"20", spotify_url: "url"},
     { id: 1, name: "Rolling Ruanas", image: "http", genres: "rock", popularity:"10", spotify_url: "url"}
    ]
  }
  end

  describe '#index' do
    before do
      get :index
    end

    it 'deploy in api/v1 path' do 
      expect({ get: 'api/v1/artists' }).to route_to(controller: 'api/v1/artists',
                                                    action: 'index')
    end

    it { expect(response.status).to eq(200) }
    
    it 'json with data struct exist' do 
      resp = JSON.parse(response.body)
      expect(resp['data']).to_not be_empty 
    end

    it 'response is ordered descending by popularity' do 
      expect(JSON.parse(response.body, symbolize_names: true)).to eq(output)
    end
  end
end
