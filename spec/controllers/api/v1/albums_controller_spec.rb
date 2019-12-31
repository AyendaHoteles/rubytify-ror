require 'rails_helper'
require 'spec_helper'

RSpec.describe Api::V1::AlbumsController, type: :controller do
    fixtures :albums
    render_views

  let(:output) do
  {
    data:[
     { id: 1, name: 'Antologia 1', image: 'http', spotify_url: 'url', total_tracks: '10' },
     { id: 2, name: 'Antologia 2', image: 'http', spotify_url: 'url', total_tracks: '10' },
     { id: 3, name: 'Antologia 3', image: 'http', spotify_url: 'url', total_tracks: '10' }
    ]
  }
  end

  after do
    DatabaseCleaner.clean_with(:truncation)
  end

  describe '#index' do
    before do
      get :index, params: { artist_id: 1 }
    end

    it 'deploy in api/v1 path' do 
      expect({ get: 'api/v1/artists/1/albums' }).to route_to(controller: 'api/v1/albums',
                                                               action: 'index', artist_id: '1')
    end

    it { expect(response.status).to eq(200) }
    
    it 'json with data struct exist' do 
      resp = JSON.parse(response.body)
      expect(resp['data']).to_not be_empty 
    end

    it 'response expected' do 
      expect(JSON.parse(response.body, symbolize_names: true)).to eq(output)
    end
  end
end
