require 'rails_helper'

RSpec.describe 'Genders Api', type: :request do
  # initialize test data
  let!(:artist) { create(:artist) }
  let!(:gender) { create(:gender) }
  let!(:album) { create(:album, artist_id: artist.id) }
  let!(:songs) { create_list(:song, 5, album_id: album.id, gender_id: gender.id) }
  let(:artist_id) { artist.id }
  let(:gender_id) { gender.id }
  let(:album_id) { album.id }
  # let(:id) { gender.first.id }

  describe 'GET /genres/:id/random_song' do
    # make HTTP get request before each example
    before { get "/genres/#{gender_id}/random_song" }

    context 'When Gender exists' do
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
      it "returns all albums artist" do
        expect(json.size).to eq(5)
      end
    end

    context "When Gender doesnt exist" do
      let(:gender_id) { 0 }

      it "returns 404" do
        expect(response).to have_http_status(404)
      end

      it "Not found message" do
        expect(response.body).to match(/Couldn't find Gender/)
      end
    end

  end


end
