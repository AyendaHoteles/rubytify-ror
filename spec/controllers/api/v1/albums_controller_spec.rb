require "rails_helper"

RSpec.describe Api::V1::AlbumsController, type: :controller do

  context 'albums#index' do
    before do
      artist = create(:artist)
      10.times { create(:album, artist: artist) }
      get(:index, params: { artist_id: artist.id })
    end

    it 'should the key to be data' do
      expect(JSON.parse(response.body)).to have_key('data')
    end

    it 'should valid keys' do
      album = JSON.parse(response.body)['data'][0]
      expect(album).to have_key('id')
      expect(album).to have_key('name')
      expect(album).to have_key('image')
      expect(album).to have_key('spotify_url')
      expect(album).to have_key('total_tracks')
    end

    it 'should return valid code response' do
      expect(response.status).to eq(200)
    end

    it 'should return many albums' do
      expect(JSON.parse(response.body)['data'].count).to eq(10)
    end
  end

end
