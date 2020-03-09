require 'rails_helper'

RSpec.describe Api::V1::AlbumsController, type: :controller do
  describe '#songs' do

    let!(:artist) { FactoryBot.create(:artist, name: 'Artist1', genres: ['salsa'], popularity: 3)  }
    let!(:album) { FactoryBot.create(:album, name: 'album1', artist: artist)  }
    let!(:song1) { FactoryBot.create(:song, name: 'song1', album: album)  }
    let!(:song2) { FactoryBot.create(:song, name: 'song2', album: album)  }

    let(:sample) do
      {
        data:[
          {
            duration_ms: 1,
            explicit: false,
            name: "song1",
            preview_url: "MyString",
            spotify_url: "MyString"
          },
          {
            duration_ms: 1,
            explicit: false,
            name: "song2",
            preview_url: "MyString",
            spotify_url: "MyString"
          }
        ]
      }
    end

    before do
      process :songs, method: :get, format: :json, params: { id: album.id }
    end

    it { expect(response.status).to eq(200) }

    it '' do
      expect({ get: "api/v1/albums/1/songs" }).to route_to(
        controller: "api/v1/albums", action: 'songs', id: "1"
      )
    end

    it 'data structuture is as required' do
      resp = JSON.parse(response.body)
      expect(resp['data']).to be_present
    end

    it 'album response' do
      expect(JSON.parse(response.body, symbolize_names: true)).to eq(sample)
    end
  end
end
