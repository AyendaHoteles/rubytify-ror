require 'rails_helper'

RSpec.describe ArtistsController, type: :controller do
  describe '#index' do
    it 'orders by popularity' do
      create(:artist, popularity: 53)
      create(:artist, popularity: 83)

      get :index

      expect(JSON.parse(response.body)['data'][0]['popularity']).to eq(83)
      expect(JSON.parse(response.body)['data'][1]['popularity']).to eq(53)
    end
  end
end
