require 'rails_helper'

RSpec.describe 'Genders API', type: :request do
  # initialize test data
  let!(:artist) { create(:artist) }
  let!(:album) { create(:album, artist_id: artist.id) }
  let!(:gender) { create(:gender) }
  let!(:song) { create(:song, album_id: album.id, gender_id: gender.id) }
  let(:album_id) { album.id }
  let(:artist_id) { artist.id }
  let(:gender_id) { gender.id }


  describe 'GET /api/v1/genres/:genre_name/random_song' do
    let(:genre_name) { gender.name }
    before { get "/api/v1/genres/#{genre_name}/random_song" }

    context 'When Genre exists' do
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
      it "returns all albums artist" do
        expect(json.size).to eq(1)
      end
    end

    context "When Artists doesnt exist" do
      let(:genre_name) { "reggaeton" }
      it "returns 404" do
        expect(response).to have_http_status(422)
      end
    end

  end
end
