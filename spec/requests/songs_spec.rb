require 'rails_helper'

RSpec.describe 'songs API', type: :request do
  # initialize test data
  let!(:artist) { create(:artist) }
  let!(:album) { create(:album, artist_id: artist.id) }
  let!(:gender) { create(:gender) }
  let!(:songs) { create_list(:song, 10, album_id: album.id, gender_id: gender.id) }
  let(:artist_id) { artist.id }
  let(:gender_id) { gender.id }
  let(:album_id) { album.id }

  # Test suite for GET /artists
  describe 'GET /albums/:id/songs' do
    # make HTTP get request before each example
    before { get "/albums/#{album_id}/songs" }

    context 'When Album exists' do
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
      it "returns all albums album" do
        expect(json.size).to eq(10)
      end
    end

    context "When Albums doesnt exist" do
      let(:album_id) { 0 }

      it "returns 404" do
        expect(response).to have_http_status(404)
      end

      it "Not found message" do
        expect(response.body).to match(/Couldn't find Album/)
      end
    end

  end
end
