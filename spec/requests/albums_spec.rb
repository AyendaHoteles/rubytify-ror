require './spec/rails_helper'


RSpec.describe Api::V1::AlbumsController, :type => :controller do
  describe "GET index" do
    let!(:artist) { create(:artist, name: 'Muse')}
    let!(:album_one) { create(:album, artist_id: artist.id) }

    before { get :index, params: {artist_id: artist.id}}

    it "has a 200 status code" do
      expect(response.status).to eq(200)
    end

    it "returns data ordered by popularity" do
      data = JSON.parse(response.body)['data']

      expect(data.first['id'].to_i).to eq album_one.id
    end
  end
end