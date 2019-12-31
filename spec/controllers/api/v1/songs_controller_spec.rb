require 'rails_helper'
require 'spec_helper'

RSpec.describe Api::V1::SongsController, type: :controller do
  fixtures :artists
  fixtures :albums
  fixtures :songs
  render_views
  

  let(:output) do
  {
    data:[
     {name: "track 1", spotify_url: 'url', preview_url: 'http', duration_ms: '3000', explicit: 'true'},
     {name: "track 2", spotify_url: 'url', preview_url: 'http', duration_ms: '3000', explicit: 'true'},
     {name: "track 3", spotify_url: 'url', preview_url: 'http', duration_ms: '3000', explicit: 'true'}
    ]
  }
  end

  describe '#index' do
    before do
      get :index, params: { album_id: 1 }
    end

    it 'deploy in api/v1 path' do 
      expect({ get: '/api/v1/albums/1/songs' }).to route_to(controller: 'api/v1/songs',
                                                               action: 'index', album_id: '1')
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

  describe '#show' do
    context 'when genre does not exist' do
        before do
          get :show, format: :json, params: { genre_name: 'urban' }
        end
  
        it { expect(response.status).to eq(404) }
      end
  end
end
