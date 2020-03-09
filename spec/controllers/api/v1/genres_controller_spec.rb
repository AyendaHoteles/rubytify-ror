require 'rails_helper'

RSpec.describe Api::V1::GenresController, type: :controller do
  describe '#random_song' do

    let!(:artist1) { FactoryBot.create(:artist, name: 'Artist1', genres: ['salsa'], popularity: 3)  }
    let!(:artist2) { FactoryBot.create(:artist, name: 'Artist1', genres: ['vallenato'], popularity: 3)  }
    let!(:album1) { FactoryBot.create(:album, name: 'album1', artist: artist1)  }
    let!(:album2) { FactoryBot.create(:album, name: 'album2', artist: artist2)  }
    let!(:song1) { FactoryBot.create(:song, name: 'song1', album: album1)  }
    let!(:song2) { FactoryBot.create(:song, name: 'song2', album: album2)  }
    let!(:song3) { FactoryBot.create(:song, name: 'song3', album: album1)  }
    let!(:song4) { FactoryBot.create(:song, name: 'song4', album: album1)  }

    before do
      process :random_song, method: :get, format: :json, params: { genre_name: artist1.genres.first }
    end

    it { expect(response.status).to eq(200) }

    it '' do
      expect({ get: "api/v1/genres/vallenato/random_song" }).to route_to(
        controller: "api/v1/genres", action: 'random_song', genre_name: "vallenato"
      )
    end

    it 'data structuture is as required' do
      resp = JSON.parse(response.body)
      expect(resp['data']).to be_present
    end

    context do
      before do
        @parsed_response = JSON.parse(response.body, symbolize_names: true)
      end

      it { expect(@parsed_response[:data]).to be_present }
      it { expect([song1.name, song2.name, song3.name, song4.name]).to include(@parsed_response[:data][:name]) }
      it { expect(@parsed_response[:data][:spotify_url]).to be_present }
      it { expect(@parsed_response[:data][:preview_url]).to be_present }
    end
  end
end
