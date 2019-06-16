require 'rails_helper'

RSpec.describe Api::V1::SongsController, type: :controller do
  before(:all) do
    @album = create(:album)
    song = create(:song, album_id: @album.id)
  end

  describe "GET songs" do

    it "returns http success" do
      get :songs, params: {id: @album.id}
      expect(response).to have_http_status(:success)
    end

  end

  describe "GET random_song" do

    it "returns http success" do
      get :random_song, params: {genre_name: 'reggae fusion'}
      expect(response).to have_http_status(:success)
    end

  end
end
