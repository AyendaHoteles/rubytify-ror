require 'rails_helper'

RSpec.describe Api::V1::ArtistsController, type: :controller do
  describe '#index' do
    let!(:artist_1) { FactoryBot.create(:artist, name: 'Artist1', genres: ['salsa'], popularity: 3)  }
    let!(:artist_2) { FactoryBot.create(:artist, name: 'Artist2', genres: ['vallenato'], popularity: 4)  }
    let!(:artist_3) { FactoryBot.create(:artist, name: 'Artist3', genres: ['salsa'], popularity: 1)  }

    let(:sample) do
      {
        data:[
          {
            id: artist_2.id,
            name: "Artist2",
            image: "MyString",
            genres: ["vallenato"],
            popularity: 4,
            spotify_url: "MyString"
          },
          {
            id: artist_1.id,
            name: "Artist1",
            image: "MyString",
            genres: ["salsa"],
            popularity: 3,
            spotify_url: "MyString"
          },
          {
            id: artist_3.id,
            name: "Artist3",
            image: "MyString",
            genres: ["salsa"],
            popularity: 1,
            spotify_url: "MyString"
          }
        ]
      }
    end

    before do
      get :index
    end

    it { expect(response.status).to eq(200) }

    it '' do
      expect({ get: 'api/v1/artists' }).to route_to(
        controller: 'api/v1/artists', action: 'index'
      )
    end

    it 'data structuture is as required' do
      resp = JSON.parse(response.body)
      expect(resp['data']).to be_present
    end

    it 'all artist are ordered descending by popularity' do
      expect(JSON.parse(response.body, symbolize_names: true)).to eq(sample)
    end
  end

  describe '#albums' do

    let!(:artist) { FactoryBot.create(:artist, name: 'Artist1', genres: ['salsa'], popularity: 3)  }
    let!(:album) { FactoryBot.create(:album, name: 'album1', artist: artist)  }
    let!(:album2) { FactoryBot.create(:album, name: 'album2', artist: artist)  }

    let(:sample) do
      {
        data:[
          {
            id: album.id,
            image: "MyString",
            name: "album1",
            spotify_url: "MyString",
            total_tracks: 1
          },
          {
            id: album2.id,
            image: "MyString",
            name: "album2",
            spotify_url: "MyString",
            total_tracks: 1
          }
        ]
      }
    end

    before do
      process :albums, method: :get, format: :json, params: { id: artist.id }
    end

    it { expect(response.status).to eq(200) }

    it '' do
      expect({ get: "api/v1/artists/1/albums" }).to route_to(
        controller: "api/v1/artists", action: 'albums', id: "1"
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
