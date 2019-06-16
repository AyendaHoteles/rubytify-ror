require 'rails_helper'

RSpec.describe Api::V1::Genres::SongsController, type: :controller do
  fixtures :songs

  describe 'routes to the albums controller' do
    it 'routes to #index' do
      expect({get: 'api/v1/genres/rock/random_song'}).
        to route_to(
          genre_name: 'rock',  
          controller: 'api/v1/genres/songs',
          action: 'index'
        )
    end
  end

  describe 'GET to #index' do
    before {
      get :index, params: { genre_name: 'rock' }
    }

    it { expect(response.status).to eq(200) }
    it { expect(json['data'].count).to eq(1) }
  end
end
