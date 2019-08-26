require './spec/rails_helper'


RSpec.describe Api::V1::ArtistsController, :type => :controller do
  describe "GET index" do
    let!(:artist_one) { create(:artist, name: 'Muse') }
    let!(:artist_two) { create(:artist, name: 'BTS') }

    before { get :index }

    it "has a 200 status code" do
      expect(response.status).to eq(200)
    end

    it "returns data ordered by popularity" do
      data = JSON.parse(response.body)['data']

      expect(data.first['id'].to_i).to eq artist_two.id
      expect(data.last['id'].to_i).to eq artist_one.id
    end

    it "returns correct data" do
      data = JSON.parse(response.body)['data']
      updated_artist_one = Artist.find(artist_one.id)
      expect(data.last['id'].to_i).to eq updated_artist_one.id
      expect(data.last['popularity']).to eq updated_artist_one.popularity
      expect(data.last['genres']).to eq updated_artist_one.genres
    end
  end
end