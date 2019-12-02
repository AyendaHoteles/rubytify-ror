require "rails_helper"

RSpec.describe Api::V1::ArtistsController, type: :controller do

  context 'artists#index' do
    before do
      create_list(:artist, 10)
      get(:index)
    end

    it 'should the key to be data' do
      expect(JSON.parse(response.body)).to have_key('data')
    end

    it 'should valid keys' do
      artist = JSON.parse(response.body)['data'][0]
      expect(artist).to have_key('id')
      expect(artist).to have_key('name')
      expect(artist).to have_key('image')
      expect(artist).to have_key('genres')
      expect(artist).to have_key('popularity')
      expect(artist).to have_key('spotify_url')
    end

    it 'should return valid code response' do
      expect(response.status).to eq(200)
    end

    it 'should return many artists' do
      expect(JSON.parse(response.body)['data'].count).to eq(10)
    end
  end

end
