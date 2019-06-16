require 'rails_helper'

RSpec.describe Api::V1::AlbumsController, type: :controller do
  before(:all) do
    @artist = create(:artist)
    album = create(:album, artist_id: @artist.id)
  end

  describe "GET albums" do

    it "returns http success" do
      get :albums, params: {id: @artist.id}
      expect(response).to have_http_status(:success)
    end

  end


end
